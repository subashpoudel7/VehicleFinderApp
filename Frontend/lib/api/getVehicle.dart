import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/models/VehicleData.dart';

class Services {
  static const String url = 'http://10.0.2.2:6000/API/vehicles';

  static Future<List<Data>> getVehicle() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;

        final vehicles = vehicleFromJson(body);
        List<Data> vehicle = vehicles.data;

        return vehicle;
      } else {}
    } catch (e) {
      return List<Data>();
    }
  }
}
