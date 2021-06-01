class AddVehicle {
  String vehicleType;
  String vehicleModel;
  String vehicleNoPlate;
  String description;
  String address;
  String price;
  String distanceTravelled;
  // String xyz;
  AddVehicle(
      {this.vehicleType,
      this.vehicleModel,
      this.vehicleNoPlate,
      this.description,
      this.address,
      this.price,
      this.distanceTravelled});
  // factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(AddVehicle instance) => <String, dynamic>{
        'vehicleType': instance.vehicleType,
        'vehicleModel': instance.vehicleModel,
        'vehicleNoPlate': instance.vehicleNoPlate,
        'description': instance.description,
        'address': instance.address,
        'price': instance.price,
        'distanceTravelled': instance.distanceTravelled,
      };
}

class VehicleResponseModel {
  final String vehicleID;
  final bool success;
  final String error;

  VehicleResponseModel({this.vehicleID, this.success, this.error});

  factory VehicleResponseModel.fromJson(Map<String, dynamic> json) {
    return VehicleResponseModel(
      vehicleID: json["vehicleID"] != null ? json["vehicleID"] : "",
      success: json["success"] != null ? json["success"] : "",
      error: json["message"] != null ? json["message"] : "",
    );
  }
}

class Vehicles {
  List<Data> data;

  Vehicles({this.data});

  Vehicles.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
