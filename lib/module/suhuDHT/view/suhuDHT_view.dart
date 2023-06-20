import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controller/suhuDHT_controller.dart';

class SuhuDHTView extends StatefulWidget {
  const SuhuDHTView({Key? key}) : super(key: key);

  Widget build(context, SuhuDHTController controller) {
    controller.view = this;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Temperature :",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 160,
              height: 160,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      color: Colors.black12,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: controller.temp!,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: Colors.orange,
                        enableAnimation: true,
                        animationDuration: 1000,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            '${controller.temp!.toStringAsFixed(1)} °C',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
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
        ),
      ),
    );
  }

  @override
  State<SuhuDHTView> createState() => SuhuDHTController();
}
