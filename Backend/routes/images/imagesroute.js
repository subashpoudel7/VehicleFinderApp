const express = require('express');
const  TokenController  = require('../../controller/token');
const imageController = require('../../controller/image');
const imageUploader = require('../../helpers/imageuploader');

const router = express.Router();

router.post('/singleupload/:vehicleID', imageUploader.imgupload.single('image'),imageController.singleupload);

router.get('/getimg/:id',imageController.getImageID)

module.exports = router;