'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const express                           = require('express');
const { check }                         = require('express-validator');

const validatePermission                = require('../../../helpers/validatePermission');

const routes                            = express.Router();



routes.post('/authenticate', validatePermission.has('auth','create'), [
        check('email').isEmail().normalizeEmail(),
        check('password').not().isEmpty()
    ], (req, res) => {
    res.status(200).json({success: true, message: "💸 Welcome To Qwery 💸, API is running on v1"});
});




module.exports = routes;