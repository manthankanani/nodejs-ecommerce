'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const jwtoken 					= require("jsonwebtoken");

// import helpers
const config                    = require('./../config');



class JWT{
    constructor(){
        this.secret         = config.key.secret;
        this.algorithm      = "HS256";
    }

    verify = (token) => {
        return jwtoken.verify(token, this.secret, { algorithm: this.algorithm });
    }
    
    sign = (payload, expiresIn) => {
        return jwtoken.sign(payload, this.secret, { expiresIn: expiresIn }, { algorithm: this.algorithm });
    }
    
    extractor = (token) => {
        const base64Url     = token.split(".")[1];
        const base64        = base64Url.replace(/-/g, "+").replace(/_/g, "/");
        const jsonPayload   = decodeURIComponent(
            atob(base64)
                .split("")
                .map(function (c) {
                    return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
                })
                .join("")
        );
        return JSON.parse(jsonPayload);
    }
}

let jwt = new JWT();
module.exports = { jwtVerify: jwt.verify, jwtSign: jwt.sign, jwtExtractor: jwt.extractor};
