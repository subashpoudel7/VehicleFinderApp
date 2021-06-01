const db = require('../database');
const {getVehicle} = require('../services/vehicle')



exports.addVehicle = (req,res) => {
    const id = req.params.userID
    console.log(id);
const {vehicleType,vehicleModel,vehicleNoPlate,description,address,price,distanceTravelled} = req.body;
console.log(req.body) //storing all the value from form to varialbes
try{
    db.query("INSERT INTO vehicle SET ?", 
    {userID:id, vehicleType:vehicleType, vehicleModel: vehicleModel, vehicleNoPlate: vehicleNoPlate, description: description, address: address, price: price, distanceTravelled: distanceTravelled},(error,results) =>{
        if(error){
           return res.send({
                success: false,
                message: "Error while registering for vehicle",
                error: error
            })
        }
        else{
            // addImage(req,res);
            res.send({
                success: true,
                message: "Vehicles have been successfully added",
                vehicleID : results.insertId.toString(),
                data: results
            })
        }
    })
}
catch(error){
    console.log(error);
}
}

exports.getVehicleDetail = async (req, res) => {
    const results = [];
    const properties = await getVehicle();
    if (properties.length <= 0) {
      res.status(200).json({
        message: "There is no data in table"
      });
    }
    for (let index = 0; index < properties.length; index++) {
      const property  = properties[index];    
    //   const images    = await getImageData(property.vehicleID);
      const user = await getUser(property.userId);
      property.userDetail = user[0];
      results.push(property);
    }
    res.send({
      data: results
    })
}


exports.getVehicle =(req,res) =>{
    try{
        db.query('SELECT * from vehicle',[],(error,results)=>{
            if(error){
              return  res.send({
                    success: false,
                    message: "Error occured."
                })}
            if(results<=0){
               return  res.send({
                    success: false,
                    message: "No data were found."
                })
            }
            else{
                res.send({
                    success: true,
                    data : results
                })
            }

            }
            
        )
    }
    catch(error){
        console.log(error);
    }
}

exports.getVehicleById =(req,res) =>{
    const id = req.params.vehicleID
    try{
        db.query('SELECT * from vehicle where vehicleID =?',[id],(error,results)=>{
            if(error){
              return  res.send({
                    success: false,
                    message: "Error occured."
                })}
            if(results<=0){
               return  res.send({
                    success: false,
                    message: "No data were found."
                })
            }
            else{
                res.send({
                    success: true,
                    data : results
                })
            }

            }
            
        )
    }
    catch(error){
        console.log(error);
    }
}


function getUser(user_ID){
    return new Promise((resolve,reject)=>{
        db.query('SELECT * from user where user_ID=?',[user_ID],(error,results)=>{
            if(results){
                resolve(results);
            }
            else{
                reject(error);
            }
        })
    })
}

