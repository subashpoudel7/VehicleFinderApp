const nodemailer = require('nodemailer');
module.exports= (name,mail,date)=>{
  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user:process.env.EMAIL,
      pass:process.env.EPASSWORD
    }
  });
  
  var mailOptions = {
    from: process.env.EMAIL,
    to: mail,
    subject: date ? "Request registered": "Successfully registered",
    html: date ? `<h1>Dear, ${name}</h1> <h1> A request for your vehicle has been successfully registered<h1> <h1> It is schedulded in ${date}</h1>` :`<h1>Welcome ${name},</h1> 
    <h2>You have been successfully registered as a user of vehicle finder
    </h2> <h2>Thanks for joining us.</h2>` 
    
  };
  
  transporter.sendMail(mailOptions, function(error, info){
    if (error) {
      console.log(error);
    } else {
      console.log('Email sent: ' + info.response);
    }
  });
}