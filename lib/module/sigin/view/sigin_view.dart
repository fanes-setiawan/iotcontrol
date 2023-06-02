import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import '../controller/sigin_controller.dart';

class SiginView extends StatefulWidget {
  const SiginView({Key? key}) : super(key: key);

  Widget build(context, SiginController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sigin"),
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
  State<SiginView> createState() => SiginController();
}