import 'package:firebase_database/firebase_database.dart';

class MessageDao {
  // final DatabaseReference _messagesRef =
  //     FirebaseDatabase.instance.reference().child('messages');
  // NOT USED
  // final DatabaseReference _messagesRef1 =
  //     FirebaseDatabase.instance.ref("sensor1");
  // final DatabaseReference _messagesRef2 =
  //     FirebaseDatabase.instance.ref("sensor2");
  // final DatabaseReference _messagesRef3 =
  //     FirebaseDatabase.instance.ref("sensor3");

  final DatabaseReference _sensorsRef =
      FirebaseDatabase.instance.ref("sensors");

  final DatabaseReference _alernateRoute =
      FirebaseDatabase.instance.ref("alternateRoute");

  // ########### ACTUATOR ###########
  Future<bool> getAlternateRouteStatus() async {
    // initial usage
    final snapshot = await _alernateRoute.child('isClogged').get();
    return snapshot.value as bool;
  }

  Stream<DatabaseEvent> getAlternateRouteData() {
    return _alernateRoute.onValue;
  }

  void changeActiveRouteStatus(bool isClogged) {
    _alernateRoute.update({"isClogged": isClogged});
  }

  // ########### SENSORS ###########

  Stream<DatabaseEvent> getSensorsData() {
    return _sensorsRef.onValue;
  }
  // not used
  // Stream<DatabaseEvent> getSensor1Data() {
  //   return _messagesRef1.onValue;
  // }

  // Stream<DatabaseEvent> getSensor2Data() {
  //   return _messagesRef2.onValue;
  // }

  // Stream<DatabaseEvent> getSensor3Data() {
  //   return _messagesRef3.onValue;
  // }
}
