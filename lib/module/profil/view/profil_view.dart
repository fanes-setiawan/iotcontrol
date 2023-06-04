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
      body: Padding(
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
                    image: NetworkImage(
                        'https://cdn.onlinewebfonts.com/svg/img_550759.png'),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.border_color_outlined),
                    label: const Text("Edit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                    ),
                    onPressed: () {
                      Get.to(EditProfileView());
                    },
                  ),
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
                            "value": "Fanes Setiawan",
                          },
                          {
                            "icon": Icons.location_on,
                            "label": "Alamat Rumah",
                            "value": "Jl.nin aja dulu Rm.09",
                          },
                          {
                            "icon": Icons.email,
                            "label": "Email",
                            "value": "fanessetiawan@gmail.com",
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
          ),
        ),
      ),
    );
  }

  @override
  State<ProfilView> createState() => ProfilController();
}
