import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/state_util.dart';
import 'package:permission_handler/permission_handler.dart';
import '../view/idProduct_view.dart';

class IdProductController extends State<IdProductView>
    implements MvcController {
  static late IdProductController instance;
  late IdProductView view;

  bool isLoading = false;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String idProduct = '';

  doIdProduct() async {
    await checkAndRequestLocationPermissions();
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot<Object?> snapshot = await FirebaseFirestore.instance
        .collection('code')
        .doc('RhUsntyLEWvTEsItOTyd')
        .get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<dynamic> codeProductList = data['codeProduct'];

    if (codeProductList.contains(idProduct)) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'idProduct': idProduct});
      print("INI ID PRODUCT");
      print(idProduct);

      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.verified_rounded,
            color: Colors.green,
            size: 30,
          ),
          title: Text('Valid'),
          content: Text('The entered product code is registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.offAll(NavbarView());
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 35,
          ),
          title: Text('Invalid'),
          content: Text('The product code entered is not registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  Future<void> checkAndRequestLocationPermissions() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      PermissionStatus requestedStatus = await Permission.location.request();
      if (requestedStatus.isDenied) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 35,
            ),
            title: Text('Location Access Denied'),
            content: Text('This app requires access to your location.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
