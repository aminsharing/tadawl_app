import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tadawl_app/models/place.dart';
import 'package:tadawl_app/models/place_search.dart';
import 'package:tadawl_app/services/places_service.dart';

class SearchOnMapProvider extends ChangeNotifier{
  final placesService = PlacesService();

  //Variables
  final TextEditingController locationController = TextEditingController();
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  Place selectedLocationStatic;


  Future searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }


  Future setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  void clearSelectedLocation() {
    selectedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    notifyListeners();
  }


  @override
  void dispose() {
    super.dispose();
    selectedLocation.close();
    locationController.dispose();
  }
}