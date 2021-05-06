import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => GreatPlaces()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlacesListScreen(),
        routes: {
          PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
