import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/addAppointment.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/appointmentListFile.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_items_builder.dart';
import 'package:time_tracker_flutter_course/app/home/models/appointment.dart';
import 'package:time_tracker_flutter_course/app/home/staff/DoctorElaborate.dart';
import 'package:time_tracker_flutter_course/app/home/staff/StaffListTile.dart';
import 'package:time_tracker_flutter_course/app/home/staff/StaffModel.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class DoctorsStaff extends StatefulWidget  {
  @override
  _DoctorsStaffState createState() => _DoctorsStaffState();
}

class _DoctorsStaffState extends State<DoctorsStaff> {

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<StaffModel>>(
      stream: database.staffStream('doctors','doc1'),
      builder: (context, snapshot) {
        return ListItemsBuilder<StaffModel>(
            snapshot: snapshot,
            itemBuilder: (context, staff) => Container(
              key: Key('a'),
              child: StaffListTile(
                  staff: staff,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorElaborate(staff: staff,)));
                  }
              ),
            ));

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Center(child: Text('Doctors & Nurses        ')),
      ),
      body: _buildContents(context),
    );
  }
}
