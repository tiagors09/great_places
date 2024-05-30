import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const googleApiKey = String.fromEnvironment('GOOGLE_API_KEY');

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=12&size=400x400&key=$googleApiKey';
  }

  static Future<String> getAdressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';

    final response = await http.get(
      Uri.parse(url),
    );

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
