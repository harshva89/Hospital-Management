
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/Services/firestoreService.dart';
import 'package:time_tracker_flutter_course/app/home/models/appointment.dart';
import 'package:time_tracker_flutter_course/app/home/models/bill.dart';
import 'package:time_tracker_flutter_course/app/home/staff/StaffModel.dart';
import 'package:time_tracker_flutter_course/services/apiPath.dart';

abstract class Database{
  Future<void> createAppointment(Appointment appointment);
  Stream<List<Appointment>> appointmentsStream();
  Stream<List<Bill>> billStream();
  Stream<List<StaffModel>> staffStream(String type, String type2);
  Future<void> DeleteAppointment(Appointment appointment);
  Future<void> createBill(Bill bill);
  Future<void> DeleteBill(Bill bill);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database{
  FirestoreDatabase({@required this.uid}) : assert(uid!=null);
  final String uid;

  final _service = FirestoreService.instance;
  @override
  Future<void> createAppointment(Appointment appointment) async => await _service.setData(
    path: APIPath.appointment(uid, appointment.id),
    data: appointment.toMap(),
  );

  @override
  Future<void> createBill(Bill bill) async => await _service.setData(
    path: APIPath.bill(uid, bill.id),
    data: bill.toMap(),
  );

  @override
  Future<void> DeleteAppointment(Appointment appointment) async => await _service.deleteData(
      path: APIPath.appointment(uid, appointment.id)
  );

  @override
  Future<void> DeleteBill(Bill bill) async => await _service.deleteData(
      path: APIPath.bill(uid, bill.id)
  );

  Stream<List<Appointment>> appointmentsStream() => _service.collectionStream(
    path: APIPath.appointments(uid),
    builder: (data, documentId) => Appointment.fromMap(data, documentId),
  );

  Stream<List<Bill>> billStream() => _service.collectionStream(
    path: APIPath.bills(uid),
    builder: (data, documentId) => Bill.fromMap(data, documentId),
  );

  Stream<List<StaffModel>> staffStream(String type, type2) => _service.collectionStream(
    path: APIPath.staffs(type, type2),
    builder:(data, documentId) => StaffModel.fromMap(data, documentId),);


}
