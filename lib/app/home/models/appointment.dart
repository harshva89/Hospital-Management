import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appointment{
  Appointment({@required this.id, @required this.name, @required this.illness, @required this.date});
  final String id;
  final String name;
  final String illness;
  final Timestamp date;

  factory Appointment.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['name'];
    final String illness = data['illness'];
    final Timestamp date = data['date'];
    return Appointment(
      id: documentId,
      name: name,
      illness: illness,
      date: date,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'illness':illness,
      'date':date,
    };
  }
}