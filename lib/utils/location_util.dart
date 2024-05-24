const googleApiKey = String.fromEnvironment('GOOGLE_API_KEY');

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=12&size=400x400&key=$googleApiKey';
  }
}
