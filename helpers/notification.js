'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const util                              = require("util");

// import helpers
const error                             = require('./error');
const smtp                              = require('./smtp');

const conn                              = require('./../db/mysql.master');

const query                             = util.promisify(conn.query).bind(conn);


class Notification {
    constructor(){
        this.emailMarketingTable = "wb_marketing_emails";
    }

    send = async (from, to, type, data, html) => {
        let addUser = await query(`INSERT INTO ${this.emailMarketingTable} (type, template_data, to_email, from_email) VALUES (?,?,?,?)`, ["email", data, to, from]);
        if (addUser.affectedRows > 0) return true;
        return false;
    }
    email = () => {

    }
    sms = () => {

    }
    fcm = () => {

    }
}

module.exports = new Notification();