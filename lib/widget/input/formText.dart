import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  final String hintText;
  final String? helperText;
  final bool obscureText;
  final Widget? suffixIcon;

  final void Function(String) onPressed;

  const FormText(
      {super.key,
      required this.hintText,
      this.helperText,
      required this.obscureText,
      this.suffixIcon,
      required this.onPressed});

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.blue,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.red,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey,
              )),
          focusColor: Colors.white,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          hintStyle: TextStyle(
            color: Colors.blueGrey,
          ),
          helperText: widget.helperText,
        ),
        onChanged: widget.onPressed,
      ),
    );
  }
}
