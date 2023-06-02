import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/navbar_view.dart';

class NavbarController extends State<NavbarView> implements MvcController {
  static late NavbarController instance;
  late NavbarView view;
  int currentIndex = 0;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  updateIndex(int newIndex) {
    currentIndex = newIndex;
    setState(() {});
    print(currentIndex);
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
