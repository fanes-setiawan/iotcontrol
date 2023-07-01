import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/widget/input/formText.dart';
import '../controller/idProduct_controller.dart';

class IdProductView extends StatefulWidget {
  const IdProductView({Key? key}) : super(key: key);

  Widget build(context, IdProductController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/logo.png",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: FormText(
                      hintText: "CODE PRODUCT",
                      obscureText: false,
                      onPressed: (value) {
                        controller.idProduct = value;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      await controller.doIdProduct();
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.blue.shade700,
                      size: 30.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<IdProductView> createState() => IdProductController();
}
