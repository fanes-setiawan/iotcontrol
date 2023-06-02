import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> implements MvcController {
  static late HomeController instance;
  late HomeView view;
  List<bool> buttomStatusList = List.generate(2, (index) => false);

  status(int index, bool val) {
    setState(() {
      val = buttomStatusList[index] = !buttomStatusList[index];
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
