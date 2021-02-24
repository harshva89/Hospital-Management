import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/models/appointment.dart';

class AppointmentListTile extends StatelessWidget {
  const AppointmentListTile({Key key, @required this.appointment, this.onTap}) : super(key: key);
  final Appointment appointment;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Appointment Name: "+appointment.name),
            SizedBox(height: 3,),
            Text("At "+appointment.date.toDate().day.toString()+"/"+appointment.date.toDate().month.toString()+"/"+appointment.date.toDate().year.toString()),
            SizedBox(height: 3,),
            Text("for "+appointment.illness),
          ],
        ),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
