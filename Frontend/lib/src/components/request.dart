import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login_signup/models/VehicleData.dart';
import 'package:flutter_login_signup/models/request.dart';
import 'package:flutter_login_signup/src/components/Vehicledetailed.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class VehicleRequest extends StatefulWidget {
  final Data vehicle;
  VehicleRequest(this.vehicle);
  @override
  _RequestInspectionState createState() => _RequestInspectionState();
}

class _RequestInspectionState extends State<VehicleRequest> {
  // var selectedRange = RangeValues(300, 1000);
  // String chosenValue;
  bool vehicleVisit = false;

  String date;
  // TextEditingController username = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController phone = TextEditingController();
  TextEditingController inquiry = TextEditingController();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  Inspection vehicleRequest = Inspection();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Vehicle Inspection"),
          backgroundColor: Color.fromRGBO(13, 71, 161, 1)),
      body: SafeArea(
        child: _requestContent(context),
      ),
    );
  }

  Widget _requestContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                ),
              ),
            ),
            // For the Request basic description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Request for Vehicle Visit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: vehicleVisit,
                              onChanged: (value) {
                                setState(() {
                                  vehicleVisit = !vehicleVisit;
                                });
                                print(
                                    "Vehicle Visit" + vehicleVisit.toString());
                              },
                            ),
                            Text(
                              " Vehicle Inspection",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 28,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    style: TextStyle(fontSize: 20),
                    controller: inquiry,
                    decoration: InputDecoration(
                      hintText: "Add further details or visit/inspection date",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Date For Visit",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) => {date = val},
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => {date = val},
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: globalFormKey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                          bottom: 15,
                          top: 5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (date == null || inquiry.text == null) {
                        EasyLoading.showError(
                            "Please provide value of inquiry and date of visit!!");
                      } else {
                        print("Proceed");
                        print(date);
                        sendReqData();
                        EasyLoading.showSuccess(
                            "Request successfully Registered");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertyListsView(
                                    vehicle: widget.vehicle)));
                      }
                    },
                    color: Color.fromRGBO(239, 108, 0, 0.9),
                    child: Container(
                      alignment: Alignment.center,
                      width: 355,
                      height: 50,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendReqData() async {
    int vehicleid = widget.vehicle.vehicleID;
    int userid = widget.vehicle.userID;
    print(vehicleVisit.toString());
    vehicleRequest = Inspection(
        vehicleVisit: vehicleVisit, inquiry: inquiry.text, date: date);
    var response = await http.post(
        "http://10.0.2.2:6000/API/$vehicleid/visitRequest/$userid",
        headers: {"Content-type": "application/json"},
        body: json.encode(vehicleRequest.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response);
    }
  }

  bool validate() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      sendReqData();
      return true;
    }
    return false;
  }
}
