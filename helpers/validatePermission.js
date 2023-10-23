'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/

// import helpers
const error                  = require('./error');


class Authorize {
    constructor(){
        
    }

    has (module, action){
        return (req, res, next) => {
            // if( ){
                
            // }
            next();
        }
    }

}

module.exports = new Authorize();