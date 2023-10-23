'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const express           = require('express');


const routes            = express.Router();


const authRoute         = require('./auth');





// import main routes
routes.use('/', authRoute);

routes.get('/', function(req, res, msg) {
    res.status(200).json({success: true, message: "💸 Welcome To Qwery 💸, API is running on v1"});
});




module.exports = routes;
