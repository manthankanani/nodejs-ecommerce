'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const util                              = require("util");
const bcrypt                            = require("bcryptjs");

const config                            = require('./../../../config');

const conn                              = require('./../../../db/mysql.master');

// import helpers
const error                             = require('./../../../helpers/error');
const notification                      = require('./../../../helpers/notification');
const pagination                        = require('./../../../helpers/pagination');
const {jwtSign}                         = require('./../../../helpers/jwt');

const utility                           = require('./../../utility/general');

const metaUtility                       = require('./metaUtility');


const query                             = util.promisify(conn.query).bind(conn);


class Partner {
    constructor(){
        this.type  = "partner";
        this.mainTable = "qt_"+this.type;
        this.saltLength = 8;
        this.activationKeyExpiry = "1d";
        this.capability = {"superuser":1,"admin":2,"subadmin":3};
        this.status = {"active":1,"blocked":2,"unverified":3};
        this.tblColumns = ["id","username", "password", "email", "capability", "nickname", "activation_key", "status", "created_at","modified_at"];
        this.metaValues = ["fname","lname"];
        this.allowedOrderBy = ["id","username","email","custom"];
        this.allowedOrder = ["ASC","DESC"];
    }

    register = () => {
         return async (req, res, next) => {
            let username, fullname, uname, nickname, activationKey, userID, sendEmail, status; 
            let { email, password, fname, lname } = req.body;

            if(await this.email_exists(email)){
                return error.sendBadRequest(res, "Your Email is Already Registered with Us");
            }  

            username            = await this.generate_username(email);
            fullname            = [fname, lname];
            nickname            = fullname.filter(Boolean).join(" ");
            activationKey       = jwtSign({ email: email, role_id: this.capability.superuser }, this.activationKeyExpiry);
            status              = this.status.unverified;
            password            = bcrypt.hashSync(password, this.saltLength);
            
            sendEmail = notification.send("from", "to", "email_verifier","data", `${config.server.domain}/create-password?token=${activationKey}`);

            userID = await this.create({
                "email": email,
                "username": username,
                "capability": this.capability.superuser,
                "nickname": nickname,
                "activation_key": activationKey,
                "status": status,
                "password": password,
                "meta":{
                    "fname": fname,
                    "lname": lname
                } 
            });
            
            if (userID) {
				return res.status(200).json({success:true, message: `User created successfully, set the password from the link sent in the mail`});
			} else {
				return error.sendBadRequest(res, "Something went wrong");
			}
        }
    }

    login = async () => {
        return async (req, res, next) => {
            
        }
    }


    list = async (returnType="",perPage=config.pagination.defaultLimit,pageNo=config.pagination.defaultPage,orderBy="id",order="DESC", filter={}, search="") => {
        let queryGenerator, selectQuery, whereQueryArray, whereQuery, orderQuery, limitQuery, result, user; 
        const {offset, limit} = pagination.getOffsetLimit(pageNo, perPage);

        queryGenerator = utility.returnQueryToArray(returnType,{"column":this.tblColumns,"meta":this.metaValues});     
        selectQuery = queryGenerator.column.join(", ");

        // Where Query Starts
        whereQueryArray = [];
        if(typeof search == "string" && search!=""){
            whereQueryArray.push(`username LIKE '%${search}%' OR email LIKE '%${search}%'`);
            if(whereQueryArray.length > 0){
                whereQueryArray[0] = "WHERE "+whereQueryArray[0];
            }
        }
        whereQuery = whereQueryArray.join(" AND ");
        // Where Query Ends

        // Order Query Starts
        if(this.allowedOrderBy.includes(orderBy) && this.allowedOrder.includes(order)){
            orderQuery = `ORDER BY ${orderBy} ${order}`;
        }
        // Order Query End

        // Limit Query Starts
        limitQuery = ` LIMIT ${offset},${limit}`;
        // Limit Query End

        result = await query(`SELECT ${selectQuery} FROM ${this.mainTable} ${whereQuery} ${orderQuery} ${limitQuery};`);

        if(result.length>0){
            for (const key of result) {
                let metaValue;
                if(queryGenerator['meta']?.length>0){
                    metaValue = await metaUtility.get_metadata(this.type, key["id"], false, false);
                    //         metakey.push(metaValue);
                    Object.keys(metaValue).forEach((key) => queryGenerator.meta.includes(key) || delete metaValue[key]);
                }
                key['meta'] = metaValue;
            }
        }
        if(result.length > 0){
            return result;
        } else {
            return false;
        }
    }
    
    create = async (data) => {
        let addUser;
        const {email, username, capability, nickname, activation_key, status, password, meta} = data;

        addUser = await query(`INSERT INTO ${this.mainTable} (username, email, capability, nickname, activation_key, status, password) VALUES (?,?,?,?,?,?,?)`, [username, email, capability, nickname, activation_key, status, password]);
        if (addUser?.affectedRows > 0) {
            this.update_user_meta(addUser.insertId, meta);
            return addUser.insertId;
        }
        return false;
    }

    update = async (id, data) => {
        let updateUser, addQuery, dataQuery;
        const {email, username, capability, nickname, activation_key, status, password, meta} = data;
        if(!id) return false;
        
        addQuery = [];
        dataQuery = {"email":email,"username":username,"capability":capability,"nickname":nickname,"activation_key":activation_key,"status":status,"password":password};
        for(const key in dataQuery) {
            if(typeof dataQuery[key]=="string" && dataQuery[key]){
                addQuery.push(`${key}='${dataQuery[key]}'`);
            }
        }
        if(addQuery.length > 0){
            addQuery = addQuery.join(", ");
            updateUser = await query(`UPDATE ${this.mainTable} SET ${addQuery} WHERE id=?`,[id]);
        }
        this.update_user_meta(id, meta);
        return true;
    }

    delete = async (id) => {
        let removeMeta, removeUser;

        removeMeta = await metaUtility.delete_all_metadata(this.type, id);
        removeUser = await query(`DELETE FROM ${this.mainTable} WHERE id = ?`, [id]);
        if (removeUser?.affectedRows > 0) {
            return removeUser.insertId;
        }
    }

    update_user_status = async(id, status) => {
        if(utility.isNumeric(status)){
            if(Object.values(this.status).indexOf(parseInt(status)) > -1){
                status = status.toString();
                return await this.update(id, {"status":status});
            }
        }
        return false;
    }

    get_user_meta = async (id, meta_key, fallback="") => {
        let metaKey;
        metaKey = await metaUtility.get_metadata(this.type, id, meta_key);
        return (metaKey)? metaKey : fallback ;
    }
    
    update_user_meta = async (id, meta_key, meta_value="") => {
        if(typeof meta_key == "string"){
            if(this.metaValues.contains(meta_key)){
                return await metaUtility.update_metadata(this.type, id, meta_key, meta_value);
            } 
        } else if(typeof meta_key == "object"){
            Object.keys(meta_key).forEach((key) => this.metaValues.includes(key) || delete meta_key[key]);
            return await metaUtility.update_metadata(this.type, id, meta_key, meta_value);
        } 
        return false;
    }

    delete_user_meta = async (id, meta_key) => {
        return await this.delete_metadata(this.type, id, meta_key);
    }

    username_exists = async (str) => {
        return await this.get_user_by('username', str);
    }

    email_exists = async (str) => {
        return await this.get_user_by('email', str);
    }
    
    user_exists = async (str) => {
        let user;
        user = await this.get_user_by('login',str);
        if(user) return true;
        return false;
    }

    get_user_by = async (field, value)=> {
        let users, allowedCase, metaKey;

        allowedCase     = ['id','username','email','login'];
        field           = field.toLowerCase();
        if(!allowedCase.includes(field)){
            return false;
        }
        
        if(field == 'username'){
            users = await query(`SELECT * FROM ${this.mainTable} WHERE username = ?;`, [value]);
        } else if(field == 'email'){
            users = await query(`SELECT * FROM ${this.mainTable} WHERE email = ?;`, [value]);
        } else if(field == 'id'){
            users = await query(`SELECT * FROM ${this.mainTable} WHERE id = ?;`, [value]);
        } else if(field == 'login') {
            users = await query(`SELECT * FROM ${this.mainTable} WHERE email = ? OR username = ?;`, [value, value]);
        }
        
        if(users.length > 0) {
            metaKey = await metaUtility.get_metadata(this.type, users[0].id);
            return {
                "id": users[0].id,
                "username": users[0].username,
                "password": users[0].password,
                "email": users[0].email,
                "capability": users[0].capability,
                "nickname": users[0].nickname,
                "activation_key": users[0].activation_key,
                "status:": users[0].status,
                "meta": metaKey,
                "created_at": users[0].created_at,
                "modified_at": users[0].modified_at,
            };
        }
        return false;
    }

    generate_username = async (email) => { 
        let uname, username;
        uname = utility.createFriendlyname(email);
        if(await this.username_exists(uname)){
            username = uname;
            for(let i=1;i<99999;i++){
                if(await this.username_exists(username)){
                    username = uname+'_'+i;
                } else {
                    break;
                }
            }
        } else {
            username = uname;
        }
        return username;
    }
}



module.exports = new Partner();