import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/homepage.dart';
import 'package:flutter_login_signup/api/addVehicleApi.dart';
import 'package:flutter_login_signup/models/addVehicleModel.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Vehiclepage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<Vehiclepage> {
  TextEditingController vehicleModel = TextEditingController();
  TextEditingController vehicleNoPlate = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController distanceTravelled = TextEditingController();

  AddVehicle addVehiclemodel = AddVehicle();
  var session = FlutterSession(); // create session instance
  List<Asset> images = [];
  // List<Asset> mainimage = [];

  Dio dio = Dio();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String vehicleType;

  File mainimage;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        mainimage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Photos",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      print(images);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(backgroundColor: Color.fromRGBO(3, 51, 121, 31)),
      body: Form(
          key: globalFormKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(145, 224, 0, 1),
                  Color.fromRGBO(113, 171, 161, 1)
                ])),
            child: ListView(children: <Widget>[
              Image.asset(
                'assets/logo.PNG',
                height: 105,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'ADD VEHICLE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: vehicleModel,
                  keyboardType: TextInputType.text,
                  validator: (input) =>
                      !(input.length > 2) ? "Plese provide valid title" : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Vehicle Model',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: distanceTravelled,
                  keyboardType: TextInputType.number,
                  validator: (input) => !(input.length > 2)
                      ? "Plese provide valid information"
                      : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'distance travelled',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: description,
                  keyboardType: TextInputType.text,
                  validator: (input) => !(input.length > 2)
                      ? "Plese provide valid description"
                      : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Description',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: address,
                  keyboardType: TextInputType.text,
                  validator: (input) => !(input.length > 2)
                      ? "Plese provide valid address"
                      : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Address',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: vehicleNoPlate,
                  keyboardType: TextInputType.text,
                  validator: (input) => !(input.length > 1)
                      ? "Please provide valid vehicle number plate"
                      : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Vehicle Number Plate',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  // obscureText: true,
                  style: TextStyle(fontSize: 17.5),
                  controller: price,
                  keyboardType: TextInputType.number,
                  validator: (input) => (input.isEmpty &&
                          input.contains(new RegExp('[A-Z][a-z]')))
                      ? "Plese provide valid vehicle price"
                      : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Price',
                      labelStyle:
                          TextStyle(fontSize: 19.0, color: Colors.black),
                      errorStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                      fillColor: Color(0x00000000),
                      filled: true),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Select Main Image for Vehicle',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: IconButton(
                  alignment: Alignment.topLeft,
                  focusColor: Colors.blue,
                  iconSize: 50,
                  splashColor: Colors.white,
                  icon: Icon(Icons.add_a_photo, color: Colors.blue, size: 50),
                  onPressed: () {
                    // takePhoto(ImageSource.gallery);
                    // loadoneImg();
                    getImage();
                    print(mainimage);
                    print("main img above ");
                  },
                ),
              ),
              // SizedBox(height: 1),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
                // width: 250,
                child: mainimage == null
                    ? Text('No image selected.')
                    : Image.file(mainimage),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Vechile Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Radio(
                        value: "Two Wheeler",
                        groupValue: vehicleType,
                        activeColor: Colors.blue,
                        onChanged: (T) {
                          print(T);
                          setState(() {
                            vehicleType = T;
                          });
                        }),
                    Text(
                      '2 wheeler',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Radio(
                      value: 'Four Wheeler',
                      groupValue: vehicleType,
                      onChanged: (T) {
                        print(T);
                        setState(() {
                          vehicleType = T;
                        });
                      },
                    ),
                    Text(
                      '4 Wheeler',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),

              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Color.fromRGBO(239, 108, 0, 0.9),
                      child: Text(
                        'Add Vehicle',
                        style: TextStyle(fontSize: 23),
                      ),
                      onPressed: () async {
                        if (validate()) {
                          VehicleAPIService apiService =
                              new VehicleAPIService();
                          apiService.addVehicle(addVehiclemodel).then((value) {
                            if (value != null) {
                              if (value.success) {
                                session.set("vehicleID", value.vehicleID);

                                sendregdata();
                                singleUpload();
                              } else {
                                session.set("message", value.error);
                                print("Error" + value.error);
                                EasyLoading.showError("Please provide values");
                              }
                            }
                          });
                        } else {
                          EasyLoading.showError(
                              'Please provide value in all the fields');
                        }
                        print("main imageafter");
                        print(mainimage);
                        // print(validate());
                      })),
            ]),
          )),
    );
  }

  void sendregdata() async {
    addVehiclemodel = AddVehicle(
        vehicleModel: vehicleModel.text,
        vehicleType: vehicleType,
        description: description.text,
        address: address.text,
        price: price.text,
        vehicleNoPlate: vehicleNoPlate.text,
        distanceTravelled: distanceTravelled.text);
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

  Future singleUpload() async {
    String filename = mainimage.path.split('/').last;
    try {
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(mainimage.path,
            filename: filename, contentType: new MediaType('image', 'png')),
      });
      int vehicleID = await FlutterSession().get("vehicleID");
      String token = await FlutterSession().get("token");
      // Dio dio = new Dio();
      var response =
          await dio.post("http://10.0.2.2:6000/API/singleupload/$vehicleID",
              data: formData,
              options: Options(
                headers: {"authorization": "$token"},
              ));
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Vehicle Thumbnail is sucessfully Stored!');
        print(response.data);
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }
}
