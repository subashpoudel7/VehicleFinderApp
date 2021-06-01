const db = require("../database");
const path  = require('path');

function singleImg (req,res) {
    var fileInfo = req.file;
    console.log(fileInfo);
    var vehicleID = req.params.vehicleID;
    console.log("vehicel"+vehicleID)
    if (req.file.filename) {
        console.log("File"+fileInfo)
        var imgUrl = 'http://10.0.2.2:6000/static/' + fileInfo.filename;
        db.query(`UPDATE vehicle SET vehicleImg = ? WHERE vehicleID = ?`,[imgUrl, vehicleID], (error, results) => {
            if (error) {
                res.status(500).json({
                    message: "Error during insertion of thumbnail image"
                })
            }

            res.status(200).json({
                message: "successfully thumbnail image inserted",
                success: true,
                data: results
            })
        })
    } else {
        res.status(500).json({
            message: "something went wrong in the Server ! ",
            url: req.file.filename
        });
    }
}

function getImageID(req, res) {
    res.sendFile('C:/Users/brother/OneDrive/Desktop/FYP/Backend/Frontuploads' + req.params.id);
}
module.exports ={
    singleupload : singleImg,
    getImageID,
};
