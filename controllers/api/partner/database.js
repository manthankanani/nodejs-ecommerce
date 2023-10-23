'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const util                              = require("util");
const fs                                = require("fs");

const config                            = require('./../../../config');

const conn                              = require('./../../../db/mysql.master');
const importer                          = require('./../../../db/mysql.importer'); 

// import helpers
const pagination                        = require('./../../../helpers/pagination');
const error                             = require('./../../../helpers/error');

const utility                           = require('./../../utility/general');

const query                             = util.promisify(conn.query).bind(conn);


class Database {
    constructor(){
        this.type  = "database";
        this.mainTable = "qt_"+this.type;
        this.random = 8;
        this.activationKeyExpiry = "1d";
        this.status = {"active":1,"pending":2,"scheduled":3,"rejected":4,"blocked":5};
        this.tblColumns = ["id","partner_id", "name", "slug", "status","modified_at", "created_at"];
        this.metaValues = [];
        this.allowedOrderBy = ["id","name","slug"];
        this.allowedOrder = ["ASC","DESC"];
    }

    create = async (data, importSchema=true) => {
        let insertRow;
        let {partner_id, store_slug, store_id, dbhost, dbuser, dbpass, dbname, dbprefix, is_master} = data;

        if(!store_id) return false;
        if(!partner_id) partner_id = 0;
        if(!dbhost) dbhost = dbhost ? dbhost : config.mysql.hostname ;
        if(!dbuser) dbuser = utility.generateRandomStr(16) ;
        if(!dbpass) dbpass = utility.generateRandomStr(16);
        if(!dbprefix) dbprefix = "qt-";
        if(!dbname) dbname = store_slug ? await this.generate_dbname(store_slug, dbprefix) : utility.generateRandomStr(16) ;

        insertRow = await query(`INSERT INTO ${this.mainTable} (partner_id, store_id, dbhost, dbuser, dbpass, dbname, dbprefix, is_master) VALUES (?,?,?,?,?,?,?,?)`, [partner_id, store_id, dbhost, dbuser , dbpass, dbname, dbprefix, is_master]);
        if (insertRow?.affectedRows > 0) {
            if(importSchema){
                await this.import_database(dbprefix+dbname);
            };
            return insertRow.insertId;
        }
        return false;
    }

    update = async (id, data) => {
        let updateRow, addQuery, dataQuery;
        const {partner_id, store_id, dbhost, dbuser , dbpass, dbname, dbprefix, is_master} = data;
        if(!id) return false;
        
        addQuery = [];
        dataQuery = {partner_id, store_id, dbhost, dbuser , dbpass, dbname, dbprefix, is_master};
        for(const key in dataQuery) {
            if(typeof dataQuery[key]=="string" && dataQuery[key]){
                addQuery.push(`${key}='${dataQuery[key]}'`);
            }
        }
        if(addQuery?.length > 0){
            addQuery = addQuery.join(", ");
            updateRow = await query(`UPDATE ${this.mainTable} SET ${addQuery} WHERE id=?`,[id]);
            if (updateRow?.affectedRows > 0) {
                return true;
            }
        }
        return false;
    }

    delete = async (id) => {
        let database, removeRow;
        database = await this.database_exists('id',id);
        removeRow = await query(`DELETE FROM ${this.mainTable} WHERE id = ?`, [id]);
        if (removeRow?.affectedRows > 0) {
            await this.delete_database(database.dbname);
            return removeRow.insertId;
        }
    }

    database_exists = async (str) => {
        return await this.get_database_by('dbname',str);
    }

    get_databases_by = async (fieldJson, perPage=null,pageNo=null) => {
        let rows, field, allowedCase, selectQuery, whereArray, whereQuery;
        const {offset, limit} = pagination.getOffsetLimit(pageNo, perPage);

        allowedCase     = ['id','dbname','partner_id','store_id'];
        field           = fieldJson.field.toLowerCase();
        if(!allowedCase.includes(field)){
            return false;
        }

        selectQuery = "*";

        // Where Query Starts
        whereArray = [];
        if(typeof fieldJson == object){
            Object.entries(fieldJson).forEach(([key, value]) => {whereArray.push(`${key}='${value}'`)});
            whereQuery = whereArray.join(" AND ");
        }
        // Where Query Ends

        // Limit Query Starts
        limitQuery = ` LIMIT ${offset},${limit}`;
        // Limit Query End

        rows = await query(`SELECT ${selectQuery} FROM ${this.mainTable} ${whereQuery} ${limitQuery};`);
        
        if(rows?.length > 0) {
            return rows;
        }
        return false;
    }

    get_database_by = async (field, value)=> {
        let rows, allowedCase;

        allowedCase     = ['id','store_id','dbname'];
        field           = field.toLowerCase();
        if(!allowedCase.includes(field)){
            return false;
        }
        rows = this.get_databases_by({field:value}, 1, 1);       
        
        if(rows?.length > 0) {
            return rows[0];
        }
        return false;
    }

    delete_database_by = async (field, value) => {
        let row, allowedCase;

        allowedCase     = ['id','store_id','dbname'];
        field           = field.toLowerCase();
        if(!allowedCase.includes(field)){
            return false;
        }
        row = this.get_database_by(field, value);       
        
        if(row?.length > 0) {
            return this.delete(row.id);
        }
        return false;
    }

    generate_dbname = async (string, prefix='') => { 
        let dname, dbname;
        
        dname = utility.createFriendlyname(string);
        if(await this.database_exists(prefix + dname)){
            dbname = dname;
            for(let i=1;i<99999;i++){
                if(await this.database_exists(prefix + dbname)){
                    dbname = dname+'_'+i;
                } else {
                    break;
                }
            }
        } else {
            dbname = dname;
        }

        dbname = utility.normalizeString(dname);
        return dbname;
    }
    
    import_database = async (dbname) => {
        let createdDB, dumpFile;
        try{
            dumpFile = fs.readFileSync('db/backups/store.sql').toString();
        } catch(e){
            return false;
        }

        createdDB = await this.create_database(dbname);
        if(createdDB){
            let query, mysql, importProcess;
            mysql = importer(dbname); 
            query = util.promisify(mysql.query).bind(mysql);

            importProcess = await query(dumpFile);
            if(importProcess?.affectedRows > 0){
                return importProcess;
            }
        }
        return false;       
    }

    create_database = async (dbname) => {
        let mysql, query, createDatabase;
        mysql = importer(); 
        query = util.promisify(mysql.query).bind(mysql);

        createDatabase = await query(`CREATE DATABASE \`${dbname}\``);
        if(createDatabase?.affectedRows>0){
            await query(`USE \`${dbname}\``);
            return true;
        }
        return false;
    }

    delete_database = async (dbname) => {
        let updates;
        updates = await query(`DROP DATABASE IF EXISTS \`${dbname}\``);
        if (updates?.affectedRows > 0) {
            return true;
        }
        return false;
    }

}



module.exports = new Database();