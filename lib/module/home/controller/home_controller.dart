import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/api/modelOpenweatherMap.dart';
import '../../../service/api/serviceWeather.dart';
import '../../../service/location/locationService.dart';
import '../../../state_util.dart';
import '../../../widget/output/loading.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> implements MvcController {
  static late HomeController instance;
  late HomeView view;
  List<bool> buttonStatusList = List.generate(2, (index) => false);
  final databaseReference = FirebaseDatabase.instance.reference();
  final LocationService locationService = LocationService();
  ServiceWeather serviceWeather = ServiceWeather();
  ModelWeather? modelWeather;
  List<double> currentSliderList = List.generate(2, (index) => 512.0);

  String currentLocation = '';
  String? code;
  bool isLoading = false; // Add isLoading variable

  Future<void> _loadButtonStatusList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? savedButtonStatusList =
        preferences.getStringList('buttonStatusList');

    if (savedButtonStatusList != null) {
      setState(() {
        buttonStatusList =
            savedButtonStatusList.map((status) => status == 'true').toList();
      });
    } else {
      setState(() {
        buttonStatusList = List.generate(2, (index) => false);
      });
    }
  }

  Future<void> _loadCurrentSliderList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? savedSliderList = preferences.getStringList('sliderValues');
    if (savedSliderList != null) {
      currentSliderList =
          savedSliderList.map((value) => double.parse(value)).toList();
    } else {
      setState(() {
        currentSliderList = List.generate(2, (index) => 512.0);
      });
    }
  }

  Future<void> _saveButtonStatusList(List<bool> newButtonStatusList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> stringList =
        newButtonStatusList.map((status) => status.toString()).toList();

    await preferences.setStringList('buttonStatusList', stringList);
  }

  Future<void> _saveCurrentSliderList(List<double> newSliderList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> sliderStringList =
        newSliderList.map((value) => value.toString()).toList();
    await preferences.setStringList('sliderValues', sliderStringList);
  }

  Future<void> fetchData() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final queryParameters = {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'appid': 'afa5ce64e1d48cf704048383f136c792',
        'units': 'metric',
      };
      final uri = Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        queryParameters,
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          modelWeather = ModelWeather.fromJson(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (err) {
      print(err);
    }
  }

  void fetchCurrentLocation() async {
    locationService.getCurrentLocation().then((Position? position) {
      if (position != null) {
        double latitude = position.latitude;
        double longitude = position.longitude;
        locationService
            .getAddressFromCoordinates(latitude, longitude)
            .then((String address) {
          setState(() {
            currentLocation = address;
          });
        });
      } else {
        print("Location is not enabled");
      }
    }).catchError((error) {
      print("Error getting current location: ${error}");
    });
  }

  void getData(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot<Object?> snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = (snapshot.data() as Map<String, dynamic>);
        setState(() {
          code = data['idProduct'];
          print(code);
        });
      }
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void status(int index, bool val) async {
    setState(() {
      buttonStatusList[index] = !buttonStatusList[index];
    });

    await _saveButtonStatusList(buttonStatusList);

    databaseReference
        .child('$code/Light/light_L${index + 1}')
        .set(buttonStatusList[index].toString());
  }

  void stateSliderValue(int index, double value) async {
    setState(() {
      currentSliderList[index] = value;
    });
    await _saveCurrentSliderList(currentSliderList);
    databaseReference.child('$code/Light/brightness_L${index + 1}').set(value);
  }

  @override
  void initState() {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    getData(uid);
    _loadButtonStatusList();
    _loadCurrentSliderList();
    fetchData();
    fetchCurrentLocation();
    _performLogin(); // Call the login function
  }

  Future<void> _performLogin() async {
    setState(() {
      isLoading = true;
    });

    // Perform your login process here

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading(); // Show the Loading widget while loading
    } else {
      return widget.build(context, this);
    }
  }
}
