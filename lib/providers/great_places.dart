import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (data) => Place(
            data['id'],
            data['title'],
            PlaceLocation(
              data['lat'],
              data['lng'],
              data['address'],
            ),
            File(
              data['image'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void> addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAdressFrom(position);

    final newPlace = Place(
      Random().nextDouble().toString(),
      title,
      PlaceLocation(
        position.latitude,
        position.longitude,
        address,
      ),
      image,
    );

    _items.add(newPlace);
    DbUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': position.latitude,
        'lng': position.longitude,
        'address': address,
      },
    );
    notifyListeners();
  }
}
