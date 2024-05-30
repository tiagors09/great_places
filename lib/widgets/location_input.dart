import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/model/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng) onSelectPosition;

  const LocationInput({
    super.key,
    required this.onSelectPosition,
  });

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          initialLocation: PlaceLocation(
            locData.latitude!,
            locData.longitude!,
            '',
          ),
        ),
      ),
    );

    if (selectedPosition == null) return;

    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll<TextStyle?>(
                  TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onPressed: _getCurrentUserLocation,
              icon: const Icon(
                Icons.location_on,
              ),
              label: const Text(
                'Localização Atual',
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll<TextStyle?>(
                  TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onPressed: _selectOnMap,
              icon: const Icon(
                Icons.map,
              ),
              label: const Text(
                'Selecione no Mapa',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
