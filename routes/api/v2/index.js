'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const express       = require('express');


const routes        = express.Router();


// import main routes
// const v1Router 		    = require('./api/v1');

routes.get('/', function(req, res, msg) {
    res.status(200).json({success: true, message: "💸 Welcome To Qwery 💸, API is running on v2"});
});


// routes.route('/:id').all(auth.verifyToken).get(users.read).put(users.update).delete(users.delete);
// routes.route('/').get(auth.verifyToken, users.list).post(users.create);


module.exports = routes;