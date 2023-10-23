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
const {asyncHandler}                    = require('../../../helpers/common');

// import controller
const authController                    = require('./../../../controllers/api/partner/auth');


const routes                            = express.Router();


routes.post('/register', validatePermission.has('partner','create'), [
    check('email').notEmpty().withMessage('Email is required').trim().isEmail().withMessage('Invalid email Address').toLowerCase(), 
    check('password').notEmpty().withMessage('password is required').isLength({min:8}).withMessage('password must be 8 characters'), 
    check('fname').notEmpty().withMessage('Firstname is required').isLength({min:1,max:20}),
    check('lname').optional(),
],  asyncHandler(authController.register()));





module.exports = routes;