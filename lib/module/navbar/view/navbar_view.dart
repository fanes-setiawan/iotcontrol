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
      Container(
        width: 100,
        height: 100,
        color: Colors.green,
      ),
      Container(
        width: 200,
        height: 200,
        color: Colors.blue,
      ),
    ];
    return Scaffold(
      body: page[controller.currentIndex],
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.deepPurple),
          Icon(Icons.calendar_month, color: Colors.deepPurple),
          Icon(Icons.people_alt, color: Colors.deepPurple),
        ],
        inactiveIcons: const [
          Text("Home"),
          Text("Calender"),
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
