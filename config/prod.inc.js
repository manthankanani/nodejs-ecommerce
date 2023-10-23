'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const dotenv 			= require("dotenv");

// Executions
dotenv.config();


/**
 * Config declaration made global
 * 
 * @author Manthan Kanani
**/
module.exports = {
	mode:{
		production: true,
		staging: false,
		development: false
	},
	server: {
		domain: process.env.DOMAIN,
		port: process.env.SERVER_PORT || 3001
	},
	mysql:{
		hostname : process.env.DB_HOSTNAME || 'localhost',
		user : process.env.DB_USER || root,
		password : process.env.DB_PASSWORD || '',
		dbname : process.env.DB_DATABASE || 'qt_database'
	},
	mongo: {
		url: `mongodb://localhost/qwery-database`,
		properties: {
			useMongoClient: true
		}
	},
	email: {
		smtp: {
			hostname : process.env.SMTP_HOST || 'localhost',
			user : process.env.SMTP_USER || "root",
			password : process.env.SMTP_PASS || '',
			port: process.env.SMTP_PORT || 465,
			fromdomain: process.env.SMTP_FROMURL || 'localhost'
		},
		imap:{}
	},
	ssl:{
		privateKey: `/etc/letsencrypt/live/${process.env.DOMAIN}/privkey.pem`,
		certificate: `/etc/letsencrypt/live/${process.env.DOMAIN}/fullchain.pem`
	},
	key: {
		secret: process.env.JWTSECRET || '85Fw86b1ZoPi879M',
		tokenExpireInSeconds: 1440
	},
	pagination: {
		defaultPage: 1,
		defaultLimit: 10
	}
};