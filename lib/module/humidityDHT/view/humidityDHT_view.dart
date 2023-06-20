import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../controller/humidityDHT_controller.dart';

class HumidityDHTView extends StatefulWidget {
  const HumidityDHTView({Key? key}) : super(key: key);

  Widget build(context, HumidityDHTController controller) {
    controller.view = this;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Humidity :",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 20),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    modifier: (double value) {
                      return '${value.toStringAsFixed(1)}%';
                    }),
                customColors: CustomSliderColors(
                  trackColor: Colors.grey,
                  shadowColor: Colors.black,
                  progressBarColors: [
                    Colors.blue.shade700,
                    Colors.blue,
                    Colors.white,
                  ],
                  progressBarColor: Colors.orange,
                ),
                customWidths: CustomSliderWidths(progressBarWidth: 10)),
            min: 0,
            max: 100,
            initialValue: controller.hum!,
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Back",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      )),
    );
  }

  @override
  State<HumidityDHTView> createState() => HumidityDHTController();
}
