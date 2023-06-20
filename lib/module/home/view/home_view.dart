import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
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
                    IconButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        print("pickedDate: $pickedDate");
                      },
                      icon: Icon(
                        Icons.date_range,
                        size: 35.0,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  "${controller.currentLocation}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12.0),
                controller.modelWeather != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "Current weather",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://openweathermap.org/img/wn/${controller.modelWeather!.icon}.png'),
                                                  fit: BoxFit.cover),
                                            ),
                                          )
                                              .animate(
                                                  onPlay: (controller) =>
                                                      controller.repeat())
                                              .shake(
                                                  duration: Duration(
                                                      milliseconds: 500)),
                                          Text(
                                            "${DateFormat('EEEE, dd/MM/yy').format(DateTime.fromMillisecondsSinceEpoch(controller.modelWeather!.sunset * 1000))}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.modelWeather!.feelsLike.toStringAsFixed(1)}",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "°C",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Precipitation   : ${controller.modelWeather!.cloudiness}%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Humidity : ${controller.modelWeather!.humidity}%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Wind Speed : ${controller.modelWeather!.windSpeed}%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Sunrise: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.modelWeather!.sunrise * 1000))}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Sunset: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.modelWeather!.sunset * 1000))}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(child: Text("loading...")),
                SizedBox(height: 20),
                Text(
                  "Menu",
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
                        "icon": Icons.thermostat_outlined,
                        "label": "Suhu",
                        "color": Color.fromARGB(108, 233, 11, 203),
                        "onTap": () {
                          Get.to(SuhuDHTView());
                        }
                      },
                      {
                        "icon": Icons.ac_unit_sharp,
                        "label": "Humidity",
                        "color": Color.fromARGB(109, 233, 26, 11),
                        "onTap": () {
                          Get.to(HumidityDHTView());
                        },
                      },
                      {
                        "icon": Icons.fireplace,
                        "label": "Gas/Smoke",
                        "color": Color.fromARGB(85, 221, 218, 23),
                        "onTap": () {
                          Get.to(AsapMq7View());
                        },
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
                            onPressed: item["onTap"],
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
                  "Button",
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
                      },
                      {
                        "icon": Icons.install_desktop_outlined,
                        "label": "LightL L2",
                        "image": AssetImage('assets/image/lamp.png'),
                        "color": Colors.white,
                      },
                    ];
                    return Container(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2, // Tentukan jumlah kolom
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.9,
                        mainAxisSpacing: 20,
                        padding: EdgeInsets.all(0),
                        children: List.generate(
                          menuRoom.length,
                          (index) {
                            var room = menuRoom[index];
                            bool buttonStatus =
                                controller.buttonStatusList[index];

                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: buttonStatus
                                    ? Colors.yellow
                                    : room['color'],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    blurRadius: 5,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: buttonStatus ? 60 : 100,
                                      height: buttonStatus ? 60 : 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: room['image'],
                                        ),
                                      ),
                                    ),
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
                                        width: 50.0,
                                        height: 25.0,
                                        valueFontSize: 14.0,
                                        toggleSize: 10.0,
                                        value: buttonStatus,
                                        borderRadius: 30.0,
                                        padding: 5.0,
                                        showOnOff: true,
                                        onToggle: (val) async {
                                          controller.status(index, val);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    if (buttonStatus)
                                      Slider(
                                        onChanged: (value) {
                                          controller.stateSliderValue(
                                              index, value);
                                        },
                                        min: 0,
                                        max: 1023,
                                        label: controller
                                            .currentSliderList[index]
                                            .round()
                                            .toString(),
                                        value:
                                            controller.currentSliderList[index],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
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
