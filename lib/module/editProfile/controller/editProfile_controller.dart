import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../../../widget/output/loading.dart';
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
  String? idProduct;
  bool isLoading =
      false; // Tambahkan variabel isLoading dengan nilai awal false

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
    setState(() {
      isLoading = true; // Set isLoading ke true saat proses penyimpanan dimulai
    });

    photo = photo ?? oldValue['photo'];
    username = username ?? oldValue['username'];
    phone = phone ?? oldValue['phone'];
    email = email ?? oldValue['email'];
    address = address ?? oldValue['address'];
    idProduct = idProduct ?? oldValue['idProduct'];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'photo': photo,
      'username': username,
      'phone': phone,
      'address': address,
      'email': email,
      'idProduct': idProduct,
    });

    setState(() {
      isLoading =
          false; // Set isLoading kembali ke false setelah proses penyimpanan selesai
    });
  }

  // Tambahkan method untuk membangun tampilan dengan pengecekan isLoading
  Widget buildWithLoading(BuildContext context) {
    if (isLoading) {
      return Loading(); // Tampilkan widget Loading jika isLoading true
    } else {
      return widget.build(context,
          this); // Tampilkan tampilan EditProfileView jika isLoading false
    }
  }
}
