import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/welcomePage.dart';
import 'package:flutter_login_signup/models/registermodel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RegisterModel regmodel = RegisterModel();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(13, 171, 61, 1)),
      body: Form(
          key: globalFormKey,
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(245, 100, 130, 0.9),
                    Color.fromRGBO(105, 221, 181, 1)
                  ])),
              child: ListView(
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 125,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.red),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(fontSize: 19),
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (input) => !(input.length > 3)
                          ? "Please provide valid name"
                          : null,
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.black),
                          fillColor: Color(0x00000000),
                          filled: true,
                          errorStyle:
                              TextStyle(fontSize: 16.0, color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(fontSize: 19),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) =>
                          !input.contains("@") ? "Email should be valid" : null,
                      decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 16.0, color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.black),
                          fillColor: Color(0x00000000),
                          filled: true),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(fontSize: 19),
                      controller: contactController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Phone Number',
                          labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.black),
                          fillColor: Color(0x00000000),
                          filled: true),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 17.5),
                      controller: passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.black),
                          fillColor: Color(0x00000000),
                          filled: true),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(fontSize: 17.5),
                      controller: confirmpasswordController,
                      validator: (input) =>
                          !(input == (passwordController.text))
                              ? "Passwords donot match"
                              : null,
                      decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 16.0, color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Re-enter Password',
                          labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.black),
                          fillColor: Colors.transparent,
                          filled: true),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Color.fromRGBO(0, 0, 255, 0.9),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () {
                            validate();
                            print(emailController.text);
                          })),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Already have an account?'),
                      FlatButton(
                        textColor: Colors.red,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 22, color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              ))),
    );
  }

  void sendregdata() async {
    regmodel = RegisterModel(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        passwordconfirm: confirmpasswordController.text,
        phone: contactController.text);
    var response = await http.post("http://10.0.2.2:6000/API/register",
        headers: {"Content-type": "application/json"},
        body: json.encode(regmodel.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } else {
      print(response);
    }
  }

  bool validate() {
    final form = globalFormKey.currentState;
    //If form is valid then it returns true
    if (form.validate()) {
      sendregdata();
      return true;
    }
    return false;
  }
}
