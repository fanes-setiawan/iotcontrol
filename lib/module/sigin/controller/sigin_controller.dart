import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/sigin_view.dart';

class SiginController extends State<SiginView> implements MvcController {
  static late SiginController instance;
  late SiginView view;

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