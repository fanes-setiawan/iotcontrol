import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import '../../../widget/input/formText.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                "assets/icons/logo.png",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              FormText(
                hintText: "Email",
                helperText: "enter your email",
                obscureText: false,
                onPressed: (value) {
                  controller.email = value;
                },
              ),
              FormText(
                hintText: "Password",
                helperText: "enter your password",
                obscureText: controller.obscureState,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.visibilitySt();
                  },
                  icon: Icon(
                    controller.obscureState
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                onPressed: (value) {
                  controller.password = value;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () async {
                  controller.doEmailLogin();
                },
                child: const Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
