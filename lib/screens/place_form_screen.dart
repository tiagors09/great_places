import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng pickedPosition) {
    setState(() {
      _pickedPosition = pickedPosition;
    });
  }

  bool get _isValidForm =>
      _titleController.text.isNotEmpty ||
      _pickedImage != null ||
      _pickedPosition != null;

  void _submitForm() {
    if (!_isValidForm) return;

    Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titulo',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ImageInput(
                      onSelectImage: _selectImage,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: LocationInput(
                      onSelectPosition: _selectPosition,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 8,
              left: 4,
              right: 4,
            ),
            child: ElevatedButton.icon(
              onPressed: _isValidForm ? _submitForm : null,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
              style: ButtonStyle(
                textStyle: const MaterialStatePropertyAll<TextStyle?>(
                  TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll<Color?>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
