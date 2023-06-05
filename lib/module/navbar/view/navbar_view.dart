import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';

import '../controller/navbar_controller.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({Key? key}) : super(key: key);

  Widget build(context, NavbarController controller) {
    controller.view = this;

    List page = [
      HomeView(),
      DataAnalystView(),
      ProfilView(),
    ];
    return Scaffold(
      body: page[controller.currentIndex],
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(Icons.home, color: Colors.blue.shade700),
          Icon(Icons.animation_rounded, color: Colors.blue.shade700),
          Icon(Icons.account_circle, color: Colors.blue.shade700),
        ],
        inactiveIcons: const [
          Text("Home"),
          Text("Data"),
          Text("Profil"),
        ],
        color: Colors.white,
        circleColor: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: controller.currentIndex,
        onTap: (newIndex) {
          controller.updateIndex(newIndex);
        },
        // tabCurve: ,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.grey,
        circleShadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  @override
  State<NavbarView> createState() => NavbarController();
}
