import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import '../controller/sigup_controller.dart';

class SigupView extends StatefulWidget {
  const SigupView({Key? key}) : super(key: key);

  Widget build(context, SigupController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sigup"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }

  @override
  State<SigupView> createState() => SigupController();
}