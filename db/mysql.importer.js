'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const mysql                     = require('mysql');

const config                    = require('../config');

/**
 * Create MySQL User Class for utils
 * 
 * @author Manthan Kanani
**/
let MySQLImporter = (database=false) => {
    return mysql.createPool({
        connectionLimit: 50,
        host: config.mysql.hostname,
        user: config.mysql.user,
        password: config.mysql.password,
        multipleStatements: true,
        connectTimeout: 60 * 60 * 1000,
        acquireTimeout: 60 * 60 * 1000,
        timeout: 60 * 60 * 1000,
        ...(database && {database}),
    });
}



/**
 * Will export MySQL POOL only
 * 
 * @author Manthan Kanani
**/
module.exports = MySQLImporter;