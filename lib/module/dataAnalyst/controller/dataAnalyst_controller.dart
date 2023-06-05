import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/dataAnalyst_view.dart';

class DataAnalystController extends State<DataAnalystView> implements MvcController {
  static late DataAnalystController instance;
  late DataAnalystView view;

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