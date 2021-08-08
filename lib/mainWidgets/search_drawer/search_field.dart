import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
    @required this.isMainPage
  }) : super(key: key);
  final bool isMainPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: SearchMapPlaceWidget(
          language: 'ar',
          hasClearButton: true,
          iconColor: Color(0xff00cccc),
          placeType: PlaceType.cities,
          placeholder: AppLocalizations.of(context).currentMapLocation,
          apiKey: 'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
          onSelected: (Place place) async {
            Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
            await place.geolocation.then((value) async{
              Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(CameraPosition(target: value.coordinates, zoom: 13));
              if(isMainPage){
                Provider.of<MainPageProvider>(context, listen: false).animateToLocation(value.coordinates, 13);
              }
              await Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }
}
