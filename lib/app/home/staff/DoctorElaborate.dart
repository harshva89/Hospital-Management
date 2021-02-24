import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/staff/StaffModel.dart';

class DoctorElaborate extends StatelessWidget  {
  final StaffModel staff;

  const DoctorElaborate({Key key, this.staff}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${staff.id}         ')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 120,),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Name: "+staff.name.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Department: "+staff.department.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Experience: "+staff.exp.toString()+" years",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Age: "+staff.age.toString()+" years",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),

          ],
        ),
      ),

    );
  }
}
