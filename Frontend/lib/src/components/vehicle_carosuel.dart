import 'package:flutter/material.dart';
import 'package:flutter_login_signup/models/VehicleData.dart';
import 'package:flutter_login_signup/src/components/Vehicledetailed.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_login_signup/api/getVehicle.dart';

class VehicleCarousel extends StatefulWidget {
  @override
  _PropertyCarouselState createState() => _PropertyCarouselState();
}

class _PropertyCarouselState extends State<VehicleCarousel> {
  List<Data> _vehicle;
  bool _loading;
  var session = FlutterSession();

  @override
  void initState() {
    _loading = true;
    super.initState();
    Services.getVehicle().then((vehicle) {
      setState(() {
        _vehicle = vehicle;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Featured vehicles',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See more',
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 410,
          // color: Colors.grey,
          child: ListView.builder( //scrollable data dinxa 1000 wata bhayepani
            scrollDirection: Axis.horizontal,
            itemCount: _vehicle.length == null ? 0 : _vehicle.length,
            itemBuilder: (BuildContext context, int index) {
              Data vehicle = _vehicle[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      // MaterialPageRoute(ropertyListsView(property: property)));
                      MaterialPageRoute(
                          builder: (context) =>
                              PropertyListsView(vehicle: vehicle)));
                  print("Tap");
                  session.set("property_id", vehicle.vehicleID);
                  session.set("user_id", vehicle.userID);
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 280,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Icon(
                                    Icons.home_filled,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  Text(
                                    vehicle.distanceTravelled,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),

                                SizedBox(
                                    height: 2,
                                    child: Divider(color: Colors.black)),

                                Text(
                                  "Rs." + vehicle.price.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  vehicle.address,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                // T
                                SizedBox(
                                    height: 30,
                                    child: Divider(color: Colors.black)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bathtub,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Text(
                                    //   vehicle.description,
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.local_parking,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    Text(
                                      vehicle.vehicleType,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 30,
                                    child: Divider(color: Colors.black)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bathtub,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      vehicle.vehicleModel,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.local_parking,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    Text(
                                      vehicle.vehicleNoPlate,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ]),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                height: 180.0,
                                width: 320.0,
                                image: NetworkImage(vehicle.vehicleImg),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Positioned(
                            //   left: 10,
                            //   bottom: 5,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: <Widget>[
                            //       Text(
                            //         vehicle.description,
                            //         style: TextStyle(color: Colors.white),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
