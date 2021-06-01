const express = require('express');
const  authController  = require('../../controller/token');
const vehicleController = require('../../controller/vehicle'); //providing path to the controller
const router = express.Router(); //using express for making router


router.post('/:userID/vehicle',authController.checkToken,vehicleController.addVehicle); 
router.get('/vehicles',vehicleController.getVehicleDetail);

module.exports =router;