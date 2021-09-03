class Location{
  final double? lat;
  final double? lng;

  // ignore: sort_constructors_first
  Location({this.lat, this.lng});

  // ignore: sort_constructors_first
  factory Location.fromJson(Map<dynamic,dynamic> parsedJson){
    return Location(
        lat: parsedJson['lat'],
        lng: parsedJson['lng']
    );
  }

}