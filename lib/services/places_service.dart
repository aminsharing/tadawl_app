import 'package:http/http.dart' as http;
import 'package:tadawl_app/models/place.dart';
import 'dart:convert' as convert;

import 'package:tadawl_app/models/place_search.dart';


class PlacesService {
  final key = 'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$key';
    var specificCountry = '&components=country:SA';
    var searchType = '&types=geocode';
    var response = await http.get(Uri.parse(url+searchType+specificCountry), headers: {
      'Accept-Language': 'ar'
    });
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String? placeId) async {
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url), headers: {
      'Accept-Language': 'ar'
    });
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

}