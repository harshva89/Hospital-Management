import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffModel{
  StaffModel({@required this.id, @required this.name, @required this.department, @required this.exp, this.age});
  final String id;
  final String name;
  final String department;
  final int exp;
  final int age;



  factory StaffModel.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['name'];
    final String department = data['department'];
    final int exp = data['exp'];
    final int age = data['age'];
    return StaffModel(
      id: documentId,
      name: name,
      department: department,
      exp: exp,
        age: age
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'department':department,
      'exp':exp,
      'age':age
    };
  }
}