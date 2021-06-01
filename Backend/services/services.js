const db = require('../database');

function getVehicleData (callBack)  {
    db.query(`SELECT * FROM VEHICLE`,
        [],
        (error, results) => {
            if (error) {
                return callBack(error);
            }
            return callBack(null, results);
        }
    )
}

function getImageData(id, callBack) {
    db.query(
        `SELECT * FROM IMAGE WHERE vehicleID = ?`,
        [id],
        (error, results) => {
            if (error) {
                return callBack(error);
            }
            console.log('Sucessfully Get');
            return callBack(null, results);
        });
}



module.exports={
    getVehicleData,
    getImageData,
}