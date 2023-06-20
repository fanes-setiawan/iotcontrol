import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/asapMq7_view.dart';

class AsapMq7Controller extends State<AsapMq7View> implements MvcController {
  static late AsapMq7Controller instance;
  late AsapMq7View view;
  StreamSubscription<DatabaseEvent>? mQ7;
  final databaseReference = FirebaseDatabase.instance.reference();
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
        subscribeToMq7();
      }
    }).catchError((error) {
      // Error handling
      print('Error: $error');
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
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    mQ7?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
