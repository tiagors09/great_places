import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      Random().nextDouble().toString(),
      title,
      PlaceLocation(0, 0, ''),
      image,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
