import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/components/appbar.dart';
import 'package:flutter_login_signup/src/components/body.dart';
import 'package:flutter_login_signup/src/loginPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Icon(
                    Icons.person_pin_rounded,
                    size: 55,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              selectedTileColor: const Color.fromRGBO(10, 255, 15, 0.5),
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 19),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              selectedTileColor: const Color.fromRGBO(10, 255, 15, 0.5),
              hoverColor: Colors.blue,
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18.5),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Body(),
      ),
      bottomNavigationBar: bottombar(context),
    );
  }
}

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      color: Colors.brown,
      onPressed: () {},
    );
  }
}
