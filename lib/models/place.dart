import 'geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;
  // ignore: sort_constructors_first
  Place({this.geometry,this.name,this.vicinity});
  // ignore: sort_constructors_first
  factory Place.fromJson(Map<String,dynamic> json){
    return Place(
      geometry:  Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }
}