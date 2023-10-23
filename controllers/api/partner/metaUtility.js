'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const util                              = require("util");

const conn                              = require('../../../db/mysql.master');

// import helpers
const utility                           = require('./../../utility/general');

const query                             = util.promisify(conn.query).bind(conn);


class metaUtility {
    constructor() {
        this.type = { // module_name: main_table
            "partner": "qt_partner",
            "store": "qt_store"
        };
    }

    //public use available
    get_metadata = async (type, id, key=false, onlyValue=true) => {
        let users, obj, metaTable;
        metaTable = this.getMetaTable(type);
        
        users = await this.get_metadataOrID(type, id);
        if(users) {
            obj = utility.generateKeyValuePair(users, "meta_key", "meta_value");
            if(key){
                return (onlyValue)? obj[key] : obj;
            } else {
                return obj;
            }
        }
        return false;
    }
    
    //public use available
    update_metadata = async (type, id, key, value="") => {
        let upsertID;

        if(typeof key == "object"){
            for(const [metaKey, metaValue] of Object.entries(key)){
                upsertID = await this.upsertMeta(type, id, metaKey, metaValue);
            }
        } else if(typeof key == "string") {
            upsertID = await this.upsertMeta(type, id, key, value);
        } else {
            return false;
        }
        return true;
    }

    //public use available
    delete_metadata = async (type, id, key) => {        
        if(key){
            return await this.delete_metadataQuery(type, id, key);
        }
        return false;
    }

    //public use available
    delete_all_metadata = async (type, id) => {
        return await this.delete_metadataQuery(type, id, "", true);
    }

    delete_metadataQuery = async (type, id, key="", all=false) => {
        let meta, metaTable;
        metaTable = this.getMetaTable(type);
        if(!metaTable) return false;

        if(!all){
            meta = await query(`DELETE FROM ${metaTable} WHERE ${type}_id=? AND meta_key=?;`, [id, key]);
        } else {
            meta = await query(`DELETE FROM ${metaTable} WHERE ${type}_id=?;`, [id]);
        }
        if (meta?.affectedRows>0) return true;
    }
    
    get_metadataOrID = async (type, id, key="", value="all") => {
        let users, metaTable, keyQuery;
        metaTable = this.getMetaTable(type);

        keyQuery="";
        if(key){
            keyQuery = ` AND meta_key='${key}' `;
        }

        users = await query(`SELECT id, meta_key, meta_value FROM ${metaTable} WHERE ${type}_id=? ${keyQuery}`, [id]);
        if(users.length>0){
            if(value=="all"){
                return users;
            } else {
                return users[0].id;
            }
        }
        return false;
    }

    upsertMeta = async(type, id, key, value) => {
        let upsertID, metaTable, users;
        metaTable = this.getMetaTable(type);
        if(!metaTable) return false;

        upsertID = await this.get_metadataOrID(type, id, key, "id");
        if(upsertID){
            users = await query(`UPDATE ${metaTable} SET meta_key=?,meta_value=? WHERE id = ?;`, [key, value, upsertID]);
            if(users?.affectedRows>0) return upsertID;
        } else {
            users = await query(`INSERT INTO ${metaTable} (${type}_id, meta_key, meta_value) VALUES (?, ?, ? );`, [id, key, value]);
            if (users?.affectedRows>0) return users.insertId;
        }
        return false;
    }
    
    isOrphan = async (type, id) => {
        let users;
        if(!this.type.hasOwnProperty(type)) return false;

        users = await query(`SELECT id FROM ${this.type[type]} WHERE id = ?;`, [id]);
        if(users.length>0) return false;
        return true;
    }
    
    getMetaTable = (metaType) => {
        if(!this.type.hasOwnProperty(metaType)) return false;
        return `${this.type[metaType]}meta`;
    }
}


module.exports = new metaUtility();