import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    return null;
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = '';
        if (placemark.locality != null) {
          address += placemark.locality! + ', ';
        }
        if (placemark.administrativeArea != null) {
          address += placemark.administrativeArea! + ', ';
        }
        if (placemark.country != null) {
          address += placemark.country!;
        }
        return address;
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown';
  }
}
