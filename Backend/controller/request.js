const db = require("../database");
// const mailhelper = require("../services/mailhelper");
const reqmail = require("../services/mailhelper")
exports.vehicleVisitRequest = (req, res) => {

    var id1 = req.params.vehicleId;
    var id2 = req.params.userId;

    const { vehicleVisit, inquiry, date } = req.body
    var vv= vehicleVisit.toString();
    console.log(vv);
    try {
        db.query(

            "INSERT INTO request SET ?",
            { userID: id2, vehicleID: id1, VehicleVisit: vv, dateForVisit: date, visitDetails: inquiry }

            , (error, results) => {
                if (error) {
                    res.send({
                        error: error,
                        message: "Error occured"
                    })
                }
                else {
                    res.send({
                        message: "Request Successfully Made",
                        success: true,
                        data: results
                    })
                    db.query(
                        "SELECT name,email FROM user WHERE User_ID = ?",[id2], 
                        (error,result) => {
                            console.log(result);
                            usersname = result[0].name,
                            usersemail = result[0].email
                            console.log(usersname,usersemail);
                            reqmail(usersname,usersemail,date);
                        }
                    )
                }
            })
    }
    catch (error) {
        console.log(error);
    }
}
