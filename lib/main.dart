import 'package:flutter/material.dart';
import 'package:great_places/screens/places_list_screen.dart';

void main() {
  runApp(const GreatPlaces());
}

class GreatPlaces extends StatelessWidget {
  const GreatPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData();
    return MaterialApp(
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PlacesListScreen(),
    );
  }
}
