'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const mysql         = require("mysql");


const config        = require('../config');


/**
 * define utility variables
 * 
 * @author Manthan Kanani
**/
const DB_HOSTNAME     = config.mysql.hostname;
const DB_USER         = config.mysql.user;
const DB_PASSWORD     = config.mysql.password;
const DB_DATABASE     = config.mysql.database;


/**
 * Create Pool to wait until a connection available and connect MySQL
 * 
 * @author Manthan Kanani
**/
const pool = mysql.createPool({
    connectionLimit: 50,
    host: DB_HOSTNAME,
    user: DB_USER,
    password: DB_PASSWORD,
    database: 'qt_database-master',
    multipleStatements: true,
    connectTimeout: 60 * 60 * 1000,
    acquireTimeout: 60 * 60 * 1000,
    timeout: 60 * 60 * 1000,
});


/**
 * Will export MySQL POOL only
 * 
 * @author Manthan Kanani
**/
module.exports = pool;