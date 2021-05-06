import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlaceScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  builder: (context, gPlace, child) => ListView.builder(
                    itemCount: gPlace.items.length,
                    itemBuilder: (ctx, i) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(gPlace.items[i].image),
                        ),
                        title: Text(gPlace.items[i].title),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
