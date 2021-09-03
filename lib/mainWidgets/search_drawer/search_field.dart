import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/search_on_map.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.selectedPage
  }) : super(key: key);
  final SelectedPage selectedPage;

  @override
  Widget build(BuildContext context) {
    return SearchOnMap(
      selectedPage: selectedPage,
    );
        // SearchMapPlaceWidget(
        //   language: 'ar',
        //   hasClearButton: true,
        //   iconColor: Color(0xff00cccc),
        //   placeType: PlaceType.geocode,
        //   placeholder: AppLocalizations.of(context).currentMapLocation,
        //   apiKey: 'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
        //   onSelected: (Place place) async {
        //     Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
        //     await place.geolocation.then((value) async{
        //       Provider.of<LocaleProvider>(context, listen: false).currentArea = CameraPosition(target: value.coordinates, zoom: 13);
        //       if(isMainPage){
        //         Provider.of<MainPageProvider>(context, listen: false).animateToLocation(value.coordinates, 13);
        //       }
        //       await Navigator.pop(context);
        //     });
        //   },
        // ),
  }
}
