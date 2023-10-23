'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const app                       = require('express');

// import helpers
const error                     = require('../helpers/error'); 

// import main routes
const partnerRouter 	        = require('./api/partner');
const v1Router 		            = require('./api/v1');
const v2Router 		            = require('./api/v2');

// test environment
const brahmastra                = require('../helpers/brahmastra')();

// Executions
const routes            = app.Router();



routes.use(error.setHeadersForCORS);             // CORS setHeader

routes.use('/api/partner', partnerRouter);          // partner router
routes.use('/api/v1', v1Router);                    // v1 router
routes.use('/api/v2', v2Router);                    // v2 router

routes.get('/', function(req, res, next) {
    res.status(200).json({success: true, message: "💸 Welcome To Qwery 💸, made by M A N T H A N"});
});





// catch 404 and forward to error handler
routes.use(function(req, res) {
    error.sendNotFound(res);
});
// error handler
routes.use(function(err, req, res, next) {
	res.locals.message 	= err.message; 												    // set locals, only providing error in development
	res.locals.error 	= req.app.get('env') === 'development' ? err : {};		
    
    console.log(err);
    err.status = err.cause || 500;
    error.sendFatalError(err, req, res);                                             // render the error page		
});
// catch 500 and forward to error handler
routes.use(function(error, req, res) {
    error.sendInternalServerError(error, res);
});










module.exports = routes;