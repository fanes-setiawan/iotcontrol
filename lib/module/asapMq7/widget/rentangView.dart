// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RentangView extends StatelessWidget {
  final Color? colorC;
  final Color? colorR;
  final Color? colorK;
  final String textColor;
  final String textKategori;
  final String textRentang;
  const RentangView({
    Key? key,
    this.colorC,
    this.colorR,
    this.colorK,
    required this.textColor,
    required this.textKategori,
    required this.textRentang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          color: colorK,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(textKategori),
            ),
          ),
        ),
        Container(
          width: 100,
          color: colorR,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(textRentang),
            ),
          ),
        ),
        Container(
          width: 100,
          color: colorC,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                textColor,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
