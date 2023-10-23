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
const storeController                    = require('./../../../controllers/api/partner/store');


const routes                            = express.Router();




routes.post('/create', validatePermission.has('store','create'), [
    check('partner_id').notEmpty().withMessage('ID is required').trim().isNumeric().withMessage('Invalid ID'), 
    check('name').notEmpty().withMessage('Name is required').isLength({min:3,max:30}).withMessage('password must be 8 characters'), 
    check('slug').optional().notEmpty().withMessage('Slug is required')
],  asyncHandler(storeController.register()));





module.exports = routes;