import 'package:flutter/material.dart';
import 'package:iotcontrol/core.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controller/chart_controller.dart';

class ChartView extends StatefulWidget {
  const ChartView({Key? key}) : super(key: key);

  Widget build(context, ChartController controller) {
    controller.view = this;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                  ],
                ),
                SizedBox(width: 20),
                Column(
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
                          customWidths:
                              CustomSliderWidths(progressBarWidth: 10)),
                      min: 0,
                      max: 100,
                      initialValue: controller.hum!,
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Gas/Smoke :",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  @override
  State<ChartView> createState() => ChartController();
}
