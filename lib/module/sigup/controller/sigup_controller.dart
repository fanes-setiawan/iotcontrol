import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/sigup_view.dart';

class SigupController extends State<SigupView> implements MvcController {
  static late SigupController instance;
  late SigupView view;

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