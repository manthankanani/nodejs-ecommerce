'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/


class Utility{

    normalizeString (str) {
        str = str.replace(/[`~!@#$%^&*()|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '')
        str = str.replace(/[`_ \-]/gi,' ');
        str = str.replace(/  +/g, '_');
        str = str.toLowerCase();
        return str;
    }

    createFriendlyname (str='') {
        let name, parts; 

        str = str.toLowerCase();
        str = str.trim();
        str = str.replace(' ', '_');
        str = str.replace(/__+/g, '_');
        if(str.includes("@")){
            parts = str.split("@");
            name = (parts.length >= 1) ? parts[0] : parts ;
        } else {
            parts = str.replace(' ', '_', str);
            name = parts.replace('/[^a-zA-Z0-9_.]/', '');
        }
        return name;
    };

    // public use available
    generateKeyValuePair(arrayObject, key, value){
        let pair={};

        for (const obj of arrayObject) {
            pair[obj[key]] = obj[value];
        }
        return pair;
    }

    generateRandomStr(length) {
        let result           = '';
		let characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		let charactersLength = characters.length;
		for(let i =0; i<length; i++){
		   result += characters.charAt(Math.floor(Math.random() * charactersLength));
		}
		return result;
    }


    makeObjectLower(obj) {
        return Object.keys(obj).reduce((accumulator, key) => {
            accumulator[key.toLowerCase()] = obj[key];
            return accumulator;
        }, {});
    }

    renewObject(allowedKeys, obj) {
        Object.keys(obj).forEach((key) => allowedKeys.includes(key) || delete obj[key])
        return obj;
    }

    /**
     * 
     * @param {*} returnVal = "id,username,password,meta:fname"
     * @param {*} shouldFrom = {"column":["id","username"],"meta":["fname","lname"]}
     * @returns {"columns":["id"],"meta":["fname"]}
     * 
     * @author Manthan Kanani
     */
    returnQueryToArray = (returnVal="", shouldFrom=false) => {
        let columns, finals, p1, p2;
        // shouldFrom = {"column":["id","username", "password", "email", "capability", "nickname", "activation_key", "status", "created_at", "modified_at"],"meta":["fname","lname"]};
        // returnVal = "id,username,password,meta:fname,meta:lname";

        finals = {"column":[]};
        if(returnVal==""){
            finals.column=shouldFrom.column;
        } else {
            columns = returnVal.split(",");
            for(let column of columns) {
                if(shouldFrom.column.includes(column)){
                    finals.column.push(column);
                } else {
                    if(column.includes(":")){
                        p1 = column.split(":")[0];
                        if(shouldFrom.hasOwnProperty(p1)){
                            p2 = column.split(":")[1];
                            if(p2 && shouldFrom[p1].includes(p2)){
                                if(finals.hasOwnProperty(p1)){
                                    finals[p1].push(p2);
                                } else {
                                    finals[p1] = [p2];
                                }
                            }
                        }
                    }
                }
            }
        }

        if(finals.column.length==0){
            finals.column.push("id");
        }
        return finals;
    }

    isNumeric = (num) => {
        if (num === '' || num === null || num == undefined || num === false) return false;
        if(num===true) return false;

        return !isNaN(num);
    }
    
}

module.exports = new Utility();