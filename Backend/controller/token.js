const jwt =require ('jsonwebtoken');

function checkToken(req, res,next){
    let token = req.get("Authorization");
    if (token) {
        jwt.verify(token, process.env.JWT_SECRET, (error, decoded) => {
            if (error) {
                res.json({
                    sucsess: false,
                    message: "Invalid Token",
                    error : error
                });
            }else{
                req.userinfo = decoded;
                console.log("id =", req.userinfo);
                next();
            }
        });
    }else{
        res.json({
            sucsess: false,
            message: "Access is denied. Unauthorized user ",
        })
    }
}

module.exports={
    checkToken: checkToken
}