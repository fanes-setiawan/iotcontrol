import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/editProfile_view.dart';

class EditProfileController extends State<EditProfileView>
    implements MvcController {
  static late EditProfileController instance;
  late EditProfileView view;
  String? photo;
  String? username;
  String? phone;
  String? email;
  String? address;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doSave(oldValue) async {
    photo = photo ?? oldValue['photo'];
    username = username ?? oldValue['username'];
    phone = phone ?? oldValue['phone'];
    email = email ?? oldValue['email'];
    address = address ?? oldValue['address'];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'photo': photo,
      'username': username,
      'phone': phone,
      'address': address,
      'email': email,
    });
  }
}
