const db = require('../database');
function getVehicle ()  {
    return new Promise((resolve, reject) => {
      db.query(
       'SELECT * FROM VEHICLE',
        [],
        (error, results) => {
          if (error) {
            reject(error);
          }
          resolve(results);
        }
      )
    })
  }
  module.exports = {
      getVehicle
  }