import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../../model/api/modelOpenweatherMap.dart';

class ServiceWeather {
  Future<ModelWeather?> fetchData() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final queryParameters = {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'appid': 'afa5ce64e1d48cf704048383f136c792',
        'units': 'metric', // Menggunakan satuan Celsius
      };
      final uri = Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        queryParameters,
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return ModelWeather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (err) {
      print(err);
    }
  }
}
