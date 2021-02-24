import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/staff/StaffModel.dart';

class StaffListTile extends StatelessWidget  {
  final StaffModel staff;
  final VoidCallback onTap;

  const StaffListTile({Key key, this.staff, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(Icons.account_circle,size: 50,),
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: "+staff.name),
                SizedBox(height: 3,),
                Text("Department: "+staff.department),
              ],
            ),
            Spacer(),
            Icon(Icons.chevron_right,size: 30,),
          ],
        ),
      ),


      onTap: onTap,
    );
  }
}
