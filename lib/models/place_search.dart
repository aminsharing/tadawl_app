class PlaceSearch {
  final String? description;
  final String? placeId;
  // ignore: sort_constructors_first
  PlaceSearch({this.description, this.placeId});
  // ignore: sort_constructors_first
  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
        description: json['description'],
        placeId: json['place_id']
    );
  }
}