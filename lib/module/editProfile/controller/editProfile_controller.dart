import 'package:flutter/material.dart';
import 'package:iotcontrol/state_util.dart';
import '../view/editProfile_view.dart';

class EditProfileController extends State<EditProfileView> implements MvcController {
  static late EditProfileController instance;
  late EditProfileView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}