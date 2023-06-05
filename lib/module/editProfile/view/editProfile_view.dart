import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/widget/input/qImagePicker.dart';
import '../controller/editProfile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  Widget build(context, EditProfileController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 24.0,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: const Text("Edit Profile"),
        titleTextStyle: TextStyle(color: Colors.grey, fontSize: 24),
        centerTitle: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text("Error");
            if (!snapshot.hasData) return const Text("No Data");
            Map<String, dynamic> item =
                (snapshot.data!.data() as Map<String, dynamic>);
            item["id"] = snapshot.data!.id;
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QImagePicker(
                      label: "Image",
                      onChanged: (value) {
                        controller.phone = value;
                      }),
                  SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: item['username'] ?? '',
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "edit your username?",
                      ),
                      onChanged: (value) {
                        controller.username = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: item['address'] ?? '',
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "edit your address?",
                      ),
                      onChanged: (value) {
                        controller.address = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: item['phone'] ?? '',
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "edit your phone number?",
                      ),
                      onChanged: (value) {
                        controller.phone = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: item['email'] ?? '',
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "edit your email?",
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save_as_rounded),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                    ),
                    onPressed: () async {
                      controller.doSave(item);
                      Get.offAll(NavbarView());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  State<EditProfileView> createState() => EditProfileController();
}
