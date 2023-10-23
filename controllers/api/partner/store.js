'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const util                              = require("util");

const conn                              = require('./../../../db/mysql.master');

// import helpers
const error                             = require('./../../../helpers/error');
const notification                      = require('./../../../helpers/notification');
const pagination                        = require('./../../../helpers/pagination');

const utility                           = require('./../../utility/general');

const database                          = require('./database');
const metaUtility                       = require('./metaUtility');


const query                             = util.promisify(conn.query).bind(conn);


class Store {
    constructor(){
        this.type  = "store";
        this.mainTable = "qt_"+this.type;
        this.saltLength = 8;
        this.activationKeyExpiry = "1d";
        this.defaultIsMaster= false;
        this.status = {"active":1,"pending":2,"scheduled":3,"rejected":4,"blocked":5};
        this.tblColumns = ["id","partner_id", "name", "slug", "status","modified_at", "created_at"];
        this.metaValues = [];
        this.allowedOrderBy = ["id","name","slug"];
        this.allowedOrder = ["ASC","DESC"];
    }

    register = () => {
         return async (req, res, next) => {
            let store_id, createStore, sendEmail, status; 
            let { partner_id, name, slug, meta } = req.body;

            if(slug && await this.slug_exists(slug)){
                return error.sendBadRequest(res, "Slug is not available");
            } else {
                slug = await this.generate_slug(slug);
            }

            partner_id          = partner_id;
            name                = name;
            status              = this.status.active;
            
            sendEmail = notification.send("from", "to", "store_create","data", `We've created new store : ${slug}`);

            store_id = await this.create({
                "partner_id": partner_id,
                "name": name,
                "status": status,
                "slug": slug,
                "meta": meta 
            });
            
            if (store_id) {
                createStore = await this.create_store({store_slug:slug,store_id,partner_id,is_master:this.defaultIsMaster});

				return res.status(200).json({success:true, message: `Store created successfully with store uname:${slug}`});
			} else {
				return error.sendBadRequest(res, "Something went wrong");
			}
        }
    }

    list = async (returnType="",perPage=null,pageNo=null,orderBy="id",order="DESC", filter={}, search="") => {
        let queryGenerator, selectQuery, whereQuery, orderQuery, limitQuery, result, user; 
        const {offset, limit} = pagination.getOffsetLimit(pageNo, perPage);

        queryGenerator = utility.returnQueryToArray(returnType,{"column":this.tblColumns,"meta":this.metaValues});     
        selectQuery = queryGenerator.column.join(", ");

        // Where Query Starts
        whereQuery = [];
        if(typeof search == "string" && search!=""){
            whereQuery.push(`username LIKE '%${search}%' OR email LIKE '%${search}%'`);
            if(whereQuery.length > 0){
                whereQuery[0] = "WHERE "+whereQuery[0];
            }
        }
        whereQuery.join(" AND ");
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
        let insertData;
        const {name, slug, partner_id, status, meta} = data;

        insertData = await query(`INSERT INTO ${this.mainTable} (partner_id, name, slug, status) VALUES (?,?,?,?)`, [partner_id, name, slug, status]);
        if (insertData?.affectedRows > 0) {
            this.update_store_meta(insertData.insertId, meta);
            return insertData.insertId;
        }
        return false;
    }

    update = async (id, data) => {
        let updateUser, addQuery, dataQuery;
        const {name, slug, partner_id, status} = data;
        if(!id) return false;
        
        addQuery = [];
        dataQuery = {"name":name,"slug":slug,"partner_id":partner_id,"status":status};
        for(const key in dataQuery) {
            if(typeof dataQuery[key]=="string" && dataQuery[key]){
                addQuery.push(`${key}='${dataQuery[key]}'`);
            }
        }
        if(addQuery.length > 0){
            addQuery = addQuery.join(", ");
            updateUser = await query(`UPDATE ${this.mainTable} SET ${addQuery} WHERE id=?`,[id]);
        }
        this.update_store_meta(id, meta);
        return true;
    }

    delete = async (id) => {
        let removeMeta, removeUser, db;

        removeMeta = await metaUtility.delete_all_metadata(this.type, id);
        removeUser = await query(`DELETE FROM ${this.mainTable} WHERE id = ?`, [id]);
        if (removeUser?.affectedRows > 0) {
            db = await database.get_database_by('store_id',id);
            if(db?.length > 0){
                database.delete('id',db.id);
            }
            return removeUser.insertId;
        }
    }

    update_store_status = async(id, status) => {
        if(utility.isNumeric(status)){
            if(Object.values(this.status).indexOf(parseInt(status)) > -1){
                status = status.toString();
                return await this.update(id, {"status":status});
            }
        }
        return false;
    }

    get_store_meta = async (id, meta_key, fallback="") => {
        let metaKey;
        metaKey = await metaUtility.get_metadata(this.type, id, meta_key);
        return (metaKey)? metaKey : fallback ;
    }
    
    update_store_meta = async (id, meta_key, meta_value="") => {
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

    delete_store_meta = async (id, meta_key) => {
        return await this.delete_metadata(this.type, id, meta_key);
    }

    slug_exists = async (str) => {
        return await this.get_store_by('slug', str);
    }
    
    store_exists = async (str) => {
        let user;
        user = await this.get_store_by('slug',str);
        if(user) return true;
        return false;
    }

    get_store_by = async (field, value)=> {
        let users, allowedCase, metaKey;

        allowedCase     = ['id','slug'];
        field           = field.toLowerCase();
        if(!allowedCase.includes(field)){
            return false;
        }
        
        if(field == 'id'){
            users = await query(`SELECT * FROM ${this.mainTable} WHERE id = ?;`, [value]);
        } else if(field == 'slug'){
            users = await query(`SELECT * FROM ${this.mainTable} WHERE slug = ?;`, [value]);
        }
        
        if(users.length > 0) {
            metaKey = await metaUtility.get_metadata(this.type, users[0].id);
            return {
                "id": users[0].id,
                "partner_id": users[0].partner_id,
                "status": users[0].status,
                "slug": users[0].slug,
                "meta": metaKey,
                "modified_at": users[0].modified_at,
                "created_at": users[0].created_at,
            };
        }
        return false;
    }

    generate_slug = async (slug) => { 
        let sname, storeslug;

        sname = utility.createFriendlyname(slug);
        if(await this.slug_exists(sname)){
            storeslug = sname;
            for(let i=1;i<99999;i++){
                if(await this.slug_exists(storeslug)){
                    storeslug = sname+'_'+i;
                } else {
                    break;
                }
            }
        } else {
            storeslug = sname;
        }
        return storeslug;
    }

    create_store = async (data) => {
        let databaseID;
        
        databaseID = await database.create(data);
        if(databaseID){
            return true;
        }
        return false;
    }
}



module.exports = new Store();