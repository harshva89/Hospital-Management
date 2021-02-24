import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/addAppointment.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/appointmentListFile.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/empty_content.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_items_builder.dart';
import 'package:time_tracker_flutter_course/app/home/models/appointment.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';
import 'package:flutter/services.dart';

class JobsPage extends StatelessWidget {


  Future<void> _delete(BuildContext context, Appointment appointment) async{
    try {
      final database = Provider.of<Database>(context);
      await database.DeleteAppointment(appointment);
    } on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Appointments')),

      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text("Your Appointments:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
          SizedBox(height: 15,),
          SingleChildScrollView(
            child: SizedBox(
              height: 600.0,
              child:_buildContents(context),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => AddAppointmentPage.show(context),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Appointment>>(
      stream: database.appointmentsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Appointment>(
          snapshot: snapshot,
          itemBuilder: (context, appointment) => Dismissible(
            key: Key('appointment-${appointment.id}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, appointment),
            child: AppointmentListTile(
                appointment: appointment,
                onTap: () =>
                    AddAppointmentPage.show(
                        context, appointment: appointment)
            ),
          ));

      },
    );
  }



}
