import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/chart_view.dart';

class ChartController extends State<ChartView> implements MvcController {
  static late ChartController instance;
  late ChartView view;

  final databaseReference = FirebaseDatabase.instance.reference();
  StreamSubscription<DatabaseEvent>? temperatureSubscription;
  StreamSubscription<DatabaseEvent>? humiditySubscription;
  StreamSubscription<DatabaseEvent>? mQ7;
  double? hum = 0.0;
  double? temp = 0.0;
  double? smoke = 0.0;
  String? code;

  void getData(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot<Object?> snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = (snapshot.data() as Map<String, dynamic>);
        setState(() {
          code = data['idProduct'];
          print(code);
        });
        subscribeToTemperature();
        subscribeToHumidity();
        subscribeToMq7();
      }
    }).catchError((error) {
      // Error handling
      print('Error: $error');
    });
  }

  void subscribeToTemperature() {
    temperatureSubscription = databaseReference
        .child('$code/Sensor_DHT/temperature')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          temp = double.parse(event.snapshot.value.toString());
          print('Temperature update received: $temp');
        });
      }
    });
  }

  void subscribeToHumidity() {
    humiditySubscription = databaseReference
        .child('$code/Sensor_DHT/humidity')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          hum = double.parse(event.snapshot.value.toString());
          print('humidity update received: $hum');
        });
      }
    });
  }

  void subscribeToMq7() {
    mQ7 = databaseReference
        .child('$code/Sensor_MQ7/coValue')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          smoke = double.parse(event.snapshot.value.toString());
          print('smoke update received: $smoke');
        });
      }
    });
  }

  @override
  void initState() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    getData(uid);
    print(code);
    print(temp);
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    temperatureSubscription?.cancel();
    humiditySubscription?.cancel();
    mQ7?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
