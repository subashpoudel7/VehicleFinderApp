const express = require('express');
const  TokenController  = require('../../controller/token');
const requestController  = require('../../controller/request');

const router = express.Router();

router.post("/:vehicleId/visitRequest/:userId",  requestController.vehicleVisitRequest);

module.exports = router;