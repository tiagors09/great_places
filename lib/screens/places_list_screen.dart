import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus lugares'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.PLACE_FORM,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(
          context,
          listen: false,
        ).loadPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (ctx, greatPlaces, child) {
                      return greatPlaces.itemsCount == 0
                          ? child!
                          : ListView.builder(
                              itemCount: greatPlaces.itemsCount,
                              itemBuilder: (ctx, index) => ListTile(
                                onTap: () {},
                                contentPadding: const EdgeInsets.all(8),
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.items[index].image,
                                  ),
                                ),
                                title: Text(greatPlaces.items[index].title),
                              ),
                            );
                    },
                    child: const Center(
                      child: Text('Nenhum local cadastrado'),
                    ),
                  ),
      ),
    );
  }
}
