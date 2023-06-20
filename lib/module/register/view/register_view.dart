import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iotcontrol/core.dart';
import '../../../widget/input/buttonText.dart';
import '../../../widget/input/formText.dart';
import '../controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  Widget build(context, RegisterController controller) {
    controller.view = this;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              "assets/icons/logotext.png",
              width: 150.0,
              height: 150.0,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 100),
            Text(
              "Sign up",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            FormText(
              hintText: "Username",
              helperText: "enter your username",
              obscureText: false,
              onPressed: (value) {
                controller.username = value;
              },
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
            if (controller.isLoading)
              SpinKitThreeBounce(
                color: Colors.blue,
                size: 40.0,
              )
            else
              ButtonText(
                color: Colors.blue,
                text: "Sign Up",
                onPressed: () async {
                  await controller.doSignupEmail();
                },
              ),
            SizedBox(height: 15.0),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(LoginView());
                },
                child: RichText(
                  text: TextSpan(
                    text: "already have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<RegisterView> createState() => RegisterController();
}
