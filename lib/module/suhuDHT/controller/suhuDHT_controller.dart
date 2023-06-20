import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/suhuDHT_view.dart';

class SuhuDHTController extends State<SuhuDHTView> implements MvcController {
  static late SuhuDHTController instance;
  late SuhuDHTView view;
  final databaseReference = FirebaseDatabase.instance.reference();
  StreamSubscription<DatabaseEvent>? temperatureSubscription;
  double? temp = 0.0;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
