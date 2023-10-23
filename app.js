'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/

// defination
const fs 				= require("fs");
const express			= require("express");
const morgan			= require("morgan");
const cors				= require('cors');


const config			= require('./config');

const app				= express();



// import main routes
const indexRouter 		= require('./routes/index');

/**
 * define utility variables
 * 
 * @author Manthan Kanani
**/
const PORT 				= config.server.port;


/**
 * Adding miiddleware to the APIs  
 * 
 * @author Manthan Kanani
**/
app.use(cors());							// enable cross-origin functionalities
app.use(express.json());					// enable request with body-parser and serve as json
app.use(morgan('dev')); 					// enable logging for the dev apps
app.use('/', indexRouter);					// enables routes for following paths


  




/**
 *  Create Server and set default message
 * 
 * @author Manthan Kanani
**/
if (config.mode.production) {
	const privateKey = fs.readFileSync(config.ssl.privateKey);
  	const certificate = fs.readFileSync(config.ssl.certificate);

	https.createServer({key: privateKey, cert: certificate}, app).listen(PORT);
} else {
	app.listen(PORT);
}