import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:iotcontrol/module/asapMq7/widget/rentangView.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controller/asapMq7_controller.dart';

class AsapMq7View extends StatefulWidget {
  const AsapMq7View({Key? key}) : super(key: key);

  Widget build(context, AsapMq7Controller controller) {
    controller.view = this;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Gas/Smoke :",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 240,
              height: 240,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    radiusFactor: 0.80,
                    showFirstLabel: true,
                    minimum: 0,
                    maximum: 500,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 50, color: Colors.green),
                      GaugeRange(
                          startValue: 51, endValue: 100, color: Colors.blue),
                      GaugeRange(
                          startValue: 101, endValue: 199, color: Colors.yellow),
                      GaugeRange(
                          startValue: 200, endValue: 299, color: Colors.red),
                      GaugeRange(
                          startValue: 300, endValue: 500, color: Colors.black)
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        needleEndWidth: 5,
                        enableAnimation: true,
                        value: controller.smoke!,
                        animationDuration: 1000,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            "${controller.smoke!.toStringAsFixed(2)} ppm",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        angle: 80,
                        positionFactor: 0.5,
                      )
                    ],
                  ),
                ],
              ),
            ),
            RentangView(
              textColor: 'Colors',
              textKategori: 'Kategori',
              textRentang: 'Rentang',
              colorC: Colors.purple.shade300,
              colorK: Colors.purple.shade300,
              colorR: Colors.purple.shade300,
            ),
            RentangView(
              textColor: 'Hijau',
              textKategori: 'Baik',
              textRentang: '0-50 ppm',
              colorC: Colors.green,
            ),
            RentangView(
              textColor: 'Biru',
              textKategori: 'Sedang',
              textRentang: '51-100 ppm',
              colorC: Colors.blue,
            ),
            RentangView(
              textColor: 'Kuning',
              textKategori: 'TidaK Sehat',
              textRentang: '101-199 ppm',
              colorC: Colors.yellow,
            ),
            RentangView(
              textColor: 'Merah',
              textKategori: 'Sangat Tidak Sehat',
              textRentang: '200-299 ppm',
              colorC: Colors.red,
            ),
            RentangView(
              textColor: 'Hitam',
              textKategori: 'Berbahaya',
              textRentang: '300-500 ppm',
              colorC: Colors.black,
            ),
            SizedBox(height: 20),
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
  State<AsapMq7View> createState() => AsapMq7Controller();
}
