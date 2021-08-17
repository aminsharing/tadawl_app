import 'package:google_maps_flutter/google_maps_flutter.dart';

class City {
  City(this.name, this.position,
      this.zoom,
      );
  final String name;
  final LatLng position;
  final double zoom;
}

List<City> cities = [
  City('الرياض', LatLng(24.786743064871313, 46.71276479959488), 10),
  City('مكة', LatLng(21.3006259043885, 39.96813545446616), 12),
  City('جدة', LatLng(22.576342745531417, 39.08629964099778), 10),
  City('المدينة', LatLng(24.571799566660626, 39.60663704759898), 11),
  City('تبوك', LatLng(28.411123176458446, 36.59025125675705), 12),
  City('عرعر', LatLng(30.959894624055636, 41.05966313614458), 12),
  City('الدمام', LatLng(25.65440368228523, 49.06466389911196), 11),
  City('حائل', LatLng(27.533274756523184, 41.707608172397784), 11),
  City('نجران', LatLng(17.60988170345048, 44.22956797899045), 13),
  City('جازان', LatLng(16.927763708964225, 42.56753012054083), 9),
  City('عسير', LatLng(19.0602778, 43.3652755), 8),
  City('الباحة', LatLng(20.077178507446337, 41.477997807412684), 13),
  City('القصيم', LatLng(26.53683241348124, 43.093180817068706), 8),
  City('الجوف', LatLng(30.467841303666642, 39.60054406680274), 8),
  City('الإحساء', LatLng(23.631197447085146, 49.857917883994986), 7),
];

List<City> engCities = [
  City('Riyadh', LatLng(24.786743064871313, 46.71276479959488), 10),
  // City('Riyadh', LatLng(24.7492077976804, 46.69643865913475), 10),
  City('Mekkah', LatLng(21.3006259043885, 39.96813545446616), 12),
  City('Jeddah', LatLng(22.576342745531417, 39.08629964099778), 10),
  City('Madinah', LatLng(24.571799566660626, 39.60663704759898), 11),
  City('Tabuk', LatLng(28.411123176458446, 36.59025125675705), 12),
  City('Arar', LatLng(30.959894624055636, 41.05966313614458), 12),
  City('Dammam', LatLng(25.65440368228523, 49.06466389911196), 11),
  City('Haill', LatLng(27.533274756523184, 41.707608172397784), 11),
  City('Najran', LatLng(17.60988170345048, 44.22956797899045), 13),
  City('Jizan', LatLng(16.927763708964225, 42.56753012054083), 9),
  City('Asir', LatLng(19.0602778, 43.3652755), 8),
  // City('Asir', LatLng(19.410222513073535, 43.01059045637273), 8),
  City('Bahah', LatLng(20.077178507446337, 41.477997807412684), 13),
  City('Qassim', LatLng(26.53683241348124, 43.093180817068706), 8),
  City('Jawf', LatLng(30.467841303666642, 39.60054406680274), 8),
  City('Ahsa', LatLng(23.631197447085146, 49.857917883994986), 7),
];

class Utils {
  static String mapStyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
  ''';
}
