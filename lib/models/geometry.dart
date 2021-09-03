import 'package:tadawl_app/models/location.dart';

class Geometry {
  final Location? location;
  // ignore: sort_constructors_first
  Geometry({this.location});

  // ignore: sort_constructors_first
  Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
      :location = Location.fromJson(parsedJson['location']);
}