import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  final String hintText;
  final String helperText;
  final bool obscureText;
  final Widget? suffixIcon;

  final void Function(String) onPressed;

  const FormText(
      {super.key,
      required this.hintText,
      required this.helperText,
      required this.obscureText,
      this.suffixIcon,
      required this.onPressed});

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue.shade500,
              ),
              borderRadius: BorderRadius.circular(50)),
          focusColor: Colors.white,
          hintText: widget.hintText,

          suffixIcon: widget.suffixIcon,
          hintStyle: TextStyle(
            color: Colors.blueGrey,
          ),
          helperText: widget.helperText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ), // Mengubah menjadi kotak
        ),
        onChanged: widget.onPressed,
      ),
    );
  }
}
