const express = require("express");
const route = require('./routes/auth/route');
const vehicleroute = require('./routes/vehicle/vehicleroute')
const imgroute = require('./routes/images/imagesroute')
const requestRoute = require('./routes/requestRoute/requestRoute')
const path = require('path');

//improting mysql
const mysql = require("mysql");

//creating main app or middle ware for project of express
const app= express();

app.use(express.json());//it recognizes the incoming json data 

app.use('/static', express.static(path.join(__dirname, 'Frontuploads'))) 
// Using routes
app.use('/API', route);

app.use('/API',vehicleroute);

app.use('/API',imgroute);
app.use('/API',requestRoute);
app.listen(process.env.PORT, () =>{
    console.log('Server started');
})