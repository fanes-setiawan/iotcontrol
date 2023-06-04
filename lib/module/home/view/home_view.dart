import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iotcontrol/core.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget build(context, HomeController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/logoIoT.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "IoT Control",
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blue[50],
                            // image: DecorationImage(
                            //   image: AssetImage('assets/image/wallp.jpg'),
                            //   fit: BoxFit.cover,
                            //   colorFilter: ColorFilter.srgbToLinearGamma(),
                            // ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cuaca \nLantai 1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "27 °C",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 55,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/image/1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Device",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Builder(
                  builder: (context) {
                    List horizontalMenuList = [
                      {
                        "icon": Icons.menu_book_outlined,
                        "label": "Menu",
                        "color": Color.fromARGB(108, 233, 11, 203),
                        "onTap": () {},
                      },
                      {
                        "icon": Icons.lightbulb_sharp,
                        "label": "Lights",
                        "color": Color.fromARGB(109, 233, 26, 11),
                        "onTap": () {},
                      },
                      {
                        "icon": Icons.connected_tv,
                        "label": "CCTV",
                        "color": Color.fromARGB(85, 221, 218, 23),
                        "onTap": () {},
                      },
                      {
                        "icon": Icons.thermostat,
                        "label": "Thermostat",
                        "color": Color.fromARGB(84, 63, 231, 12),
                        "onTap": () {},
                      },
                      {
                        "icon": Icons.fireplace,
                        "label": "Gas",
                        "color": Color.fromARGB(83, 12, 231, 184),
                        "onTap": () {},
                      },
                    ];
                    return SizedBox(
                      height: 70.0,
                      child: ListView.builder(
                        itemCount: horizontalMenuList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = horizontalMenuList[index];
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blueGrey,
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              backgroundColor: Colors.transparent,
                              splashFactory: InkSplash.splashFactory,
                              shadowColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: item["color"],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      item["icon"],
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  item["label"],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Rooms",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Builder(
                  builder: (context) {
                    List menuRoom = [
                      {
                        "icon": Icons.install_desktop_outlined,
                        "label": "Light L1",
                        "image": AssetImage('assets/image/lamp.png'),
                        "color": Colors.white,
                        "onTap": () {},
                      },
                      {
                        "icon": Icons.install_desktop_outlined,
                        "label": "LightL L2",
                        "image": AssetImage('assets/image/lamp.png'),
                        "color": Colors.white,
                        "onTap": () {},
                      },
                    ];
                    return Container(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2, // Tentukan jumlah kolom
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        padding: EdgeInsets.all(0),
                        children: List.generate(menuRoom.length, (index) {
                          var room = menuRoom[index];
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.buttomStatusList[index]
                                  ? Colors.yellow
                                  : room['color'],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: room['image'],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  room['label'],
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  child: FlutterSwitch(
                                    width: 65.0,
                                    height: 35.0,
                                    valueFontSize: 14.0,
                                    toggleSize: 20.0,
                                    value: controller.buttomStatusList[index],
                                    borderRadius: 30.0,
                                    padding: 10.0,
                                    showOnOff: true,
                                    onToggle: (val) async {
                                      controller.status(index, val);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<HomeView> createState() => HomeController();
}
