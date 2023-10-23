'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const mysql         = require("mysql");
const config        = require('../config');


/**
 * Create MySQL User Class for utils
 * 
 * @author Manthan Kanani
**/
class MySQL {
    constructor(host, user, pass, dbname){
        this.host = host ? DB_HOSTNAME : config.mysql.hostname;
        this.user = user ? DB_USER : config.mysql.user;
        this.password = pass ? DB_PASSWORD : config.mysql.password ;
        this.database = dbname ? DB_DATABASE: config.mysql.database ;
        
        return this.createPool();
    }

    createPool (){
        mysql.createPool({
            connectionLimit: 50,
            host: this.host,
            user: this.user,
            password: this.password,
            database: this.database,
            multipleStatements: true,
            connectTimeout: 60 * 60 * 1000,
            acquireTimeout: 60 * 60 * 1000,
            timeout: 60 * 60 * 1000,
        });
    }
}


/**
 * Will export MySQL POOL only
 * 
 * @author Manthan Kanani
**/
module.exports = () =>{
    new MySQL()
};