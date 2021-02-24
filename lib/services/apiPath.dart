class APIPath {
  static String appointment(String uid, String appointmentId) => '/users/$uid/appointments/$appointmentId';
  static String appointments(String uid) => 'users/$uid/appointments';
  static String bill(String uid, String billid) => '/users/$uid/bills/$billid';
  static String bills(String uid) => 'users/$uid/bills';
  static String staffs(String type, String type2) => 'staff/$type/$type2';
  static String staff(String type, String staffId) => 'staff/$type/staffs/$staffId';
}