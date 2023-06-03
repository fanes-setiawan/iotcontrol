import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> implements MvcController {
  static late HomeController instance;
  late HomeView view;
  List<bool> buttomStatusList = List.generate(2, (index) => false);
  final databaseReference = FirebaseDatabase.instance.reference();

  status(int index, bool val) {
    setState(() {
      val = buttomStatusList[index] = !buttomStatusList[index];
      databaseReference.child('light_L${index + 1}').set(val.toString());
    });
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
