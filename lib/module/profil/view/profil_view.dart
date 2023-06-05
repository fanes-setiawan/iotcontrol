import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import '../controller/profil_controller.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  Widget build(context, ProfilController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: const Text("My Profil"),
        titleTextStyle: TextStyle(color: Colors.grey, fontSize: 24),
        centerTitle: true,
        actions: [],
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
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
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(item["photo"] ??
                                'https://cdn.onlinewebfonts.com/svg/img_550759.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text("aktif"),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(EditProfileView());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: Center(
                                child: Text("Edit Profil"),
                              )),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          onPressed: () async {
                            controller.doLogout();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 24,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraint) {
                              List data = [
                                {
                                  "icon": Icons.emoji_people,
                                  "label": "Nama",
                                  "value": item["username"],
                                },
                                {
                                  "icon": Icons.location_on,
                                  "label": "Alamat Rumah",
                                  "value": item['address'],
                                },
                                {
                                  "icon": Icons.phone_rounded,
                                  "label": "Nomer Telepon",
                                  "value": item['phone'],
                                },
                                {
                                  "icon": Icons.email,
                                  "label": "Email",
                                  "value": item['email'],
                                },
                              ];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ListView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  clipBehavior: Clip.none,
                                  itemBuilder: (context, index) {
                                    var item = data[index];
                                    return ListTile(
                                      leading: Icon(item['icon']),
                                      title: Text(item['label'] ?? ''),
                                      subtitle: Text(item["value"] ?? ''),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  @override
  State<ProfilView> createState() => ProfilController();
}
