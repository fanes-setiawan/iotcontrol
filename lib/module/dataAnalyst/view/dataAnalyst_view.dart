import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import '../controller/dataAnalyst_controller.dart';

class DataAnalystView extends StatefulWidget {
  const DataAnalystView({Key? key}) : super(key: key);

  Widget build(context, DataAnalystController controller) {
    controller.view = this;

    return SafeArea(
      child: Container(
        height: 100.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<DataAnalystView> createState() => DataAnalystController();
}
