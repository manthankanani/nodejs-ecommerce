'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/

// import helpers
const response                  = require('./response');


class Request {
    constructor(){
        
    }

    // params (args = {}){
    //     return (req, res, next) => {
    //         if(typeof args != 'object'){
    //             response.sendBadRequest(res, "Invalid Argument must be an object");
    //         }
    //         if(!Object.keys(args).length){
    //             next();
    //         }
    //         for (const key in args) {
    //             if(args[key].required){
    //                 if(!req.body[key]){
    //                     response.sendBadRequest(res, `missing argument : ${key}`);
    //                 } else {
    //                     console.log(key, args[key].required);
    //                     if(req.body[key]){
    //                         console.log(1);
    //                     }
    //                 }
    //             } else {
                    
    //             }
    //         }
    //         next();
    //     }
    // }

}

module.exports = new Request();