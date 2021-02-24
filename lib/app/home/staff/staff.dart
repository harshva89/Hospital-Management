import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/staff/ManagementStaff.dart';
import 'package:time_tracker_flutter_course/app/home/staff/TechStaff.dart';
import 'package:time_tracker_flutter_course/app/home/staff/doctorsStaff.dart';

class Staff extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Staff         ')),
      ),
      body: ListView(
        children: <Widget>[
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsStaff()));
          },
          trailing: Icon(Icons.chevron_right),
            title: Row(
              children: [
                Icon(Icons.local_hospital),
                SizedBox(width: 7,),
                Text('Doctors & Nurses'),
              ],
            ),
        ),
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TechStaff()));
          },
          trailing: Icon(Icons.chevron_right),
          title: Row(
            children: [
              Icon(Icons.people),
              SizedBox(width: 7,),
              Text('Technical Staff'),
            ],
          ),
        ),
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManagementStaff()));
          },
          trailing: Icon(Icons.chevron_right),
          title: Row(
            children: [
              Icon(Icons.collections_bookmark),
              SizedBox(width: 7,),
              Text('Management Staff'),
            ],
          ),
          ),
        ],
      ),


    );
  }
}
