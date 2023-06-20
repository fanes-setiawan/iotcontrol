// import 'dart:async';

// import 'package:background_service/background_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

// class DataAnalystBackground {
//   static late DataAnalystBackground instance;
//   final databaseReference = FirebaseDatabase.instance.reference();
//   StreamSubscription<DatabaseEvent>? temperatureSubscription;
//   String uid = FirebaseAuth.instance.currentUser!.uid;
//   List<Map<String, dynamic>> temperatureData = [];

//   void startBackgroundProcess() {
//     getData();
//   }

//   void getData() {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((DocumentSnapshot<Object?> snapshot) {
//       if (snapshot.exists) {
//         Map<String, dynamic> data = (snapshot.data() as Map<String, dynamic>);
//         String code = data['idProduct'];
//         print(code);
//         subscribeToTemperature(code);
//       }
//     }).catchError((error) {
//       // Error handling
//       print('Error: $error');
//     });
//   }

//   void subscribeToTemperature(String code) {
//     temperatureSubscription = databaseReference
//         .child('$code/Sensor_DHT/temperature')
//         .onValue
//         .listen((event) {
//       if (event.snapshot.value != null) {
//         double temp = double.parse(event.snapshot.value.toString());
//         print('Temperature update received: $temp');
//         // Add temperature data to the list
//         temperatureData.add({
//           'temperature': temp,
//           'time': DateTime.now(),
//         });
//         // Call the function to send temperature data to Firestore
//         sendTemperatureToFirestore();
//       }
//     });
//   }

//   void sendTemperatureToFirestore() {
//     FirebaseFirestore.instance.collection('users').doc(uid).update({
//       'dataSensprDHT': temperatureData,
//     }).then((value) {
//       print('Temperature data sent to Firestore');
//       // Clear the temperatureData list after sending
//       // temperatureData.clear();
//     }).catchError((error) {
//       // Error handling
//       print('Error: $error');
//     });
//   }

//   void stopBackgroundProcess() {
//     temperatureSubscription?.cancel();
//   }
// }

// void onStart() {
//   final backgroundProcess = DataAnalystBackground();
//   backgroundProcess.startBackgroundProcess();

//   final service = BackgroundService();
//   print("halo tol");
//   service.onDataReceived.listen((event) {
//     // if (event!["action"] == "setAsForeground") {
//     //   service.setForegroundMode(true);
//     //   return;
//     // }

//     // if (event["action"] == "setAsBackground") {
//     //   service.setForegroundMode(false);
//     //   return;
//     // }

//     // if (event["action"] == "stopService") {
//     //   service.stopBackgroundService();
//     //   backgroundProcess.stopBackgroundProcess();
//     // }
//     print("halo dek");
//     service.setForegroundMode(false);
//     backgroundProcess.startBackgroundProcess();
//   });

//   service.setForegroundMode(true);
//   Timer.periodic(Duration(seconds: 1), (timer) async {
//     if (!(await service.isServiceRunning())) timer.cancel();
//     service.setNotificationInfo(
//       title: "My App Service",
//       content: "Updated at ${DateTime.now()}",
//     );

//     service.sendData(
//       action: DateTime.now().toIso8601String(),
//     );
//   });
// }


