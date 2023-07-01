import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/widget/input/buttonText.dart';
import 'package:iotcontrol/widget/input/formText.dart';
import '../../../widget/output/loading.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  "Sign in",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                ButtonText(
                  color: Colors.blue,
                  text: "Sign In",
                  onPressed: () async {
                    await controller.doEmailLogin();
                  },
                ),
                SizedBox(height: 15.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(RegisterView());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "don't have account yet? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("-or-"),
                ),
                InkWell(
                  onTap: () async {
                    await controller.doGoogleLogin();
                  },
                  child: Image.asset(
                    "assets/icons/iconsGoogle.png",
                    width: 80,
                    height: 30,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          if (controller.isLoading) Loading(),
        ],
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
