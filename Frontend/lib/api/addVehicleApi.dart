import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/addVehicleModel.dart';
import 'package:flutter_session/flutter_session.dart';

class VehicleAPIService {
  Future<VehicleResponseModel> addVehicle(AddVehicle addvehiclemodel) async {
    int userId = await FlutterSession().get("id");
    String url = "http://10.0.2.2:6000/API/$userId/vehicle";
    String token = await FlutterSession().get("token");
    print(userId);
    final response = await http.post(url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "$token"
        },
        body: json.encode(addvehiclemodel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      return VehicleResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
