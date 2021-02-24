import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/models/appointment.dart';
import 'package:time_tracker_flutter_course/app/home/models/bill.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';
import 'package:flutter/services.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({Key key, @required this.database, this.appointment}) : super(key: key);
  final Database database;
  final Appointment appointment;

  static Future<void> show(BuildContext context, {Appointment appointment}) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => AddAppointmentPage(database: database, appointment: appointment),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {


  final _formKey = GlobalKey<FormState>();

  String _name;
  String _illness;

  @override
  void initState(){
    super.initState();
  if(widget.appointment!=null){
    _name = widget.appointment.name;
    _illness = widget.appointment.illness;
    _date = widget.appointment.date.toDate();
    _time = TimeOfDay.fromDateTime(_date);
    //TODO
  }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final appointments = await widget.database.appointmentsStream().first;
        final allNames = appointments.map((appointment) => appointment.name).toList();
        if(widget.appointment!=null){
          allNames.remove(widget.appointment.name);
        }
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different appointment name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.appointment?.id ?? documentIdFromCurrentDate();
          Timestamp _dateTS = Timestamp.fromDate(_date);
          final appointment = Appointment(
              id: id,
              name: _name,
              illness: _illness,
              date: _dateTS
          );
          await widget.database.createAppointment(appointment);
          final bill1 = Bill(
            id: id,
            title:'Consultation Fee',
            cost: 300,
            date: _dateTS
          );
          await widget.database.createBill(bill1);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.appointment==null ? 'New Appointment' : 'Edit Appointment'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();


  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: _date,
        lastDate: new DateTime(2022)
    );

    if(picked != null && picked!=_date){
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date=picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    if(picked != null && picked!=_time){
      print('Date selected: ${_time.toString()}');
      setState(() {
        _time=picked;
        _date = DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
      });
    }
  }


  List<Widget> _buildFormChildren() {
    return [
      Container(
        child: widget.appointment==null ? TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          initialValue: _name,
          validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
          onSaved: (value) => _name = value,
        ) : Text("Appointment name: "+_name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
      ),
      Container(
        child: widget.appointment==null ? TextFormField(
          decoration: InputDecoration(labelText: 'Illness'),
          initialValue: _illness,
          validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
          onSaved: (value) => _illness = value,
        ) : Text("\nIllness: "+_illness,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
      ),
      SizedBox(height: 20,),
      Text(widget.appointment==null ? "\nSelect Appointment Time:" : "Appointment Time:",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
      SizedBox(height: 15,),

      Container(
        child: widget.appointment==null ? RaisedButton(
          child: Text('Select Date'),
          onPressed: (){_selectDate(context);},
        ) : null,
      ),
      Text('Date selected: '+_date.day.toString()+'/'+_date.month.toString()+'/'+_date.year.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),

      SizedBox(height: 8,),

      Container(
        child: widget.appointment==null ? RaisedButton(
          child: Text('Select Time'),
          onPressed: (){_selectTime(context);},
        ) : null,
      ),
      Text('Time selected: ${_time.toString().substring(10,15)}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
    ];
  }
}
