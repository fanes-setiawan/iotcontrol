import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/login_view.dart';

class LoginController extends State<LoginView> implements MvcController {
  static late LoginController instance;
  late LoginView view;

  bool obscureState = true;

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
      Get.offAll(NavbarView());
    } on Exception catch (err) {
      print("login error: ${err}");
    }
  }

  doGoogleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      try {
        await googleSignIn.disconnect();
      } catch (_) {}

      try {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        var userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint("userCredential: $userCredential");
        // TODO: on login success
        //------------------
        final user = userCredential.user;
        final String? username = user?.displayName;
        final String? email = user?.email;
        final String? id = user?.uid;
        final String? phone = user?.phoneNumber;

        final FirebaseFirestore db = FirebaseFirestore.instance;
        try {
          await db.collection('users').doc(id).set({
            'username': username,
            'email': email,
            'phone': phone,
            'photo': user?.photoURL,
            'id': id,
          });
        } on Exception catch (err) {
          print(err);
        }

        Get.offAll(NavbarView());
      } catch (_) {}
    } on Exception catch (err) {
      print(err);
    }
  }
}
