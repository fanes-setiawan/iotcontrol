import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/module/home/view/home_view.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/login_view.dart';

class LoginController extends State<LoginView> implements MvcController {
  static late LoginController instance;
  late LoginView view;

  bool obscureState = false;

  visibilitySt() {
    obscureState = !obscureState;
    setState(() {}); // Memperbarui tampilan dengan setState
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  String email = "";
  String password = "";

  doEmailLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(HomeView());
    } on Exception catch (err) {
      print("login error: ${err}");
    }
  }
}
