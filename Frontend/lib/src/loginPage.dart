import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/addVehicle.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_login_signup/models/loginmodel.dart';
import 'package:flutter_login_signup/api/loginapi.dart';
import 'package:flutter_login_signup/src/homepage.dart';
import 'package:flutter_login_signup/src/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isApiCallProcess = false;
  Model requestModel = Model();

  var session = FlutterSession(); // create session instance

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(backgroundColor: Color.fromRGBO(13, 171, 61, 1)),
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(245, 100, 130, 0.9),
                Color.fromRGBO(105, 221, 181, 1)
              ])),
          child: Form(
              key: globalFormKey,
              child: ListView(
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 105,
                  ),
                  Image.asset(
                    'assets/login.png',
                    height: 165,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: nameController,
                      validator: (input) => !input.contains('@')
                          ? "Email Id should be valid"
                          : null,
                      style: TextStyle(fontSize: 17.5),
                      decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 16.0, color: Colors.white),
                          border: OutlineInputBorder(),
                          labelText: 'Username/Email',
                          fillColor: Colors.transparent,
                          filled: true),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(fontSize: 17.5),
                      controller: passwordController,
                      validator: (input) => !(input.length > 3)
                          ? "Please provide password!!"
                          : null,
                      decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 16.0, color: Colors.white),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          fillColor: Colors.transparent,
                          filled: true),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Vehiclepage()));
                    },
                    textColor: Colors.black,
                    child: Text('Forgot Password ?'),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () async {
                            if (validate()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              APIService apiService1 = new APIService();
                              apiService1.login(requestModel).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  if (value.token.isNotEmpty) {
                                    final snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    session.set("name", value.name);
                                    session.set("token", value.token);
                                    session.set("id", value.id);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  } else {
                                    final snackBar =
                                        SnackBar(content: Text(value.error));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                }
                              });
                            }
                          })),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Don\'t have an account?'),
                      FlatButton(
                        textColor: Colors.red,
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              )),
        ));
  }

  void sendlogindata() async {
    requestModel =
        Model(email: nameController.text, password: passwordController.text);
  }

  bool validate() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      sendlogindata();
      return true;
    }
    return false;
  }
}
