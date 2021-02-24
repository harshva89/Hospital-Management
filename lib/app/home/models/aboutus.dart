import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutusPage extends StatefulWidget {
  @override
  _AboutusPageState createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('About Us         ')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text("About Us",
                style: TextStyle(color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "images/about.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 120),
              child: Text("HMS is a hospital management system where users can book thier appointments whenever and wherever they want and can view their previous bookings easily.\n\n"
                  "User will get their bills directly in their accounts tab, which will keep record of all previous bills, and also show the newly added bills.\n\n"
                  "Staff details are shown for users to know more about the doctors, their experience, and other services. This staff data can be updated or deleted by the hospital management via the database servers.\n\n"
                "Contact us tab contains various ways to communicate with us easily via mail, or contact number.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, height: 1.2, letterSpacing: 1,  fontWeight: FontWeight.w300),),
            ),
          ],
        ),
      ),
    );

  }
}