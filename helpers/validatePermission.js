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

    has (capabilities, action){
        return (req, res, next) => {
            if(capabilities.length > 0){
                let token = req.headers.authorization.split(' ')[1];
                
                let user = jwtVerify(token);
                if(user){
                    if(capabilities.includes(user.role)){
                        delete user.iat;
                        delete user.exp;
                        req.user = user;
                    } else {
                        return error.sendForbidden(res, "Not Authorized or invalid token.");
                    }
                } else {
                    return error.sendForbidden(res, "Not Authorized or invalid token.");
                }
            } 
            next();
        }
    }

}

module.exports = new Authorize();
