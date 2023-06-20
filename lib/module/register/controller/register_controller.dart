import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/register_view.dart';

class RegisterController extends State<RegisterView> implements MvcController {
  static late RegisterController instance;
  late RegisterView view;
  bool obscureState = true;
  bool isLoading = false; // Tambahkan variabel isLoading
  final FirebaseAuth auth = FirebaseAuth.instance;

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
  String username = "";
  String email = "";
  String password = "";

  doSignupEmail() async {
    try {
      setState(() {
        isLoading =
            true; // Mengatur isLoading menjadi true saat proses sign up dimulai
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = auth.currentUser;
      if (user != null) {
        final FirebaseFirestore db = FirebaseFirestore.instance;
        try {
          await db.collection('users').doc(user.uid).set({
            'username': username,
            'email': email,
            'password': password,
            'id': FirebaseAuth.instance.currentUser!.uid,
          });
        } on Exception catch (err) {
          print(err);
        }
      }

      Get.to(LoginView());

      setState(() {
        isLoading =
            false; // Mengatur isLoading menjadi false setelah proses sign up selesai
      });
    } on Exception catch (err) {
      print("signup gagal: ${err}");
    }
  }
}
