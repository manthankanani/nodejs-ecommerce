'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const nodemailer    = require('nodemailer');
const config        = require('./../config');

async function email_helper (from, to, subject, html) {
    const transporter = nodemailer.createTransport({
        debug: !config.mode.production,
        logger: !config.mode.production,
        host: config.email.smtp.hostname,
        port: config.email.smtp.port,
        secure: true,
        auth: {
            user: config.email.smtp.user,
            pass: config.email.smtp.password,
        },
    });
    const mailOptions = {
        from: (from !== '') ? from : config.email.smtp.defaultuser,
        to: to,
        subject: subject,
        html: html
    };
    await transporter.sendMail(mailOptions, function(err, info) {
        if (err) {
            return false;
        } else {
            console.log('info : ', info)
            return true;
        }
    });
}

module.exports = email_helper;