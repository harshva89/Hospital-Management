import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bill{
  Bill({@required this.id, @required this.title, @required this.cost, @required this.date, this.note, this.prescription});
  final String id;
  final String title;
  final int cost;
  final Timestamp date;
  final String note;
  final String prescription;
  factory Bill.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String title = data['title'];
    final int cost = data['cost'];
    final Timestamp date = data['date'];
    final String note = data['note'];
    final String prescription = data['prescription'];
    return Bill(
      id: documentId,
      title: title,
      cost: cost,
      date: date,
        note:note,
        prescription:prescription
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title':title,
      'cost':cost,
      'date': date,
      'note':note,
      'prescription':prescription
    };
  }
}