'use strict'

/**
 * import required files and define static constants
 * 
 * @author Manthan Kanani
**/
const express                           = require('express');
const { check }                         = require('express-validator');

// import helpers
const validatePermission                = require('../../../helpers/validatePermission');
const { asyncHandler }                  = require('../../../helpers/common');


// import controller



const routes                            = express.Router();




routes.post('/register', validatePermission.has('partner','create'), [
    check('email').notEmpty().withMessage('Email is required').trim().isEmail().withMessage('Invalid email Address').toLowerCase(), 
    check('password').notEmpty().withMessage('password is required').isLength({min:8}).withMessage('password must be 8 characters'), 
    check('fname').notEmpty().withMessage('Firstname is required').isLength({min:1,max:20}),
    check('lname').optional(),
], asyncHandler (async (req, res) => {
    console.log(req.body);
    return res.status(200).json({success: true, message: req.body});
}));


// routes.post('/authenticate', validatePermission.has('auth','create'), [
//         check('email').isEmail().normalizeEmail(),
//         check('password').not().isEmpty()
//     ], (req, res) => {
//     return res.status(200).json({success: true, message: "💸 Welcome To Qwery 💸, API is running on v1"});
// });




module.exports = routes;