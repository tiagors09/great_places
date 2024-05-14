import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation(this.latitude, this.longitude);
}

class Place {
  final String id;
  final String title;
  final File image;
}
