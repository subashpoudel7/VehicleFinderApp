import 'dart:convert';

VehicleData vehicleFromJson(String str) =>
    VehicleData.fromJson(json.decode(str));

String vehicleToJson(VehicleData data) => json.encode(data.toJson());

class VehicleData {
  List<Data> data;

  VehicleData({this.data});
  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int vehicleID;
  int userID;
  String vehicleType;
  String vehicleModel;
  String vehicleNoPlate;
  String description;
  String address;
  String price;
  String distanceTravelled;
  String vehicleImg;

  Data(
      {this.vehicleID,
      this.userID,
      this.vehicleType,
      this.vehicleModel,
      this.vehicleNoPlate,
      this.description,
      this.address,
      this.price,
      this.distanceTravelled,
      this.vehicleImg});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleID = json['vehicleID'];
    userID = json['userID'];
    vehicleType = json['vehicleType'];
    vehicleModel = json['vehicleModel'];
    vehicleNoPlate = json['vehicleNoPlate'];
    description = json['description'];
    address = json['address'];
    price = json['price'];
    distanceTravelled = json['distanceTravelled'];
    vehicleImg = json['vehicleImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleID'] = this.vehicleID;
    data['userID'] = this.userID;
    data['vehicleType'] = this.vehicleType;
    data['vehicleModel'] = this.vehicleModel;
    data['vehicleNoPlate'] = this.vehicleNoPlate;
    data['description'] = this.description;
    data['address'] = this.address;
    data['price'] = this.price;
    data['distanceTravelled'] = this.distanceTravelled;
    data['vehicleImg'] = this.vehicleImg;
    return data;
  }
}
