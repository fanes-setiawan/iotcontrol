import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/humidityDHT_view.dart';

class HumidityDHTController extends State<HumidityDHTView>
    implements MvcController {
  static late HumidityDHTController instance;
  late HumidityDHTView view;
  StreamSubscription<DatabaseEvent>? humiditySubscription;
  final databaseReference = FirebaseDatabase.instance.reference();
  double? hum = 0.0;
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
        subscribeToHumidity();
      }
    }).catchError((error) {
      // Error handling
      print('Error: $error');
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

  @override
  void initState() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    getData(uid);
    print(uid);
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    humiditySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
