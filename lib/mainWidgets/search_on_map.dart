import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/search_on_map_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SelectedPage{
  mainPage,
  menu,
  locationScreen
}

class SearchOnMap extends StatelessWidget {
  SearchOnMap({
    Key? key,
    required this.selectedPage,
  }) : super(key: key);
  final SelectedPage selectedPage;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchOnMapProvider>(
      create: (context) => SearchOnMapProvider(),
      builder: (context, _){
        return Consumer<SearchOnMapProvider>(
            builder: (context, searchOnMap, _){
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: (searchOnMap.searchResults??[]).isNotEmpty ? 60.0 + (searchOnMap.searchResults!.length*25.0) : 60.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchOnMap.locationController,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.currentMapLocation,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                              hintStyle: TextStyle(
                                color: Colors.grey[850],
                              ),
                            ),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              color: Colors.grey[850],
                            ),
                            onChanged: (value) => searchOnMap.searchPlaces(value),
                            onTap: () => searchOnMap.clearSelectedLocation(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: searchOnMap.searchResults != null && searchOnMap.searchResults!.isNotEmpty ? 100.0 : 0.0,
                          child: Stack(
                            children: [
                              if (searchOnMap.searchResults != null &&
                                  searchOnMap.searchResults!.isNotEmpty)
                                Container(
                                    height: 100.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.0),
                                        backgroundBlendMode: BlendMode.darken)),
                              if (searchOnMap.searchResults != null)
                                Container(
                                  height: 100.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount: searchOnMap.searchResults!.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            searchOnMap.searchResults![index].description!,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          onTap: () async{
                                            await searchOnMap.setSelectedLocation(
                                                searchOnMap.searchResults![index].placeId).then((value) async {
                                              Provider.of<LocaleProvider>(context, listen: false).initialCameraPosition = CameraPosition(target: LatLng(searchOnMap.selectedLocationStatic!.geometry!.location!.lat!, searchOnMap.selectedLocationStatic!.geometry!.location!.lng!), zoom: 13);
                                              if(selectedPage == SelectedPage.mainPage) {
                                                Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
                                                Provider.of<MainPageProvider>(context, listen: false).animateToLocation(LatLng(searchOnMap.selectedLocationStatic!.geometry!.location!.lat!, searchOnMap.selectedLocationStatic!.geometry!.location!.lng!), 13);
                                                Navigator.pop(context);
                                              }else if(selectedPage == SelectedPage.locationScreen){
                                                Provider.of<AddAdProvider>(context, listen: false).animateToLocation(LatLng(searchOnMap.selectedLocationStatic!.geometry!.location!.lat!, searchOnMap.selectedLocationStatic!.geometry!.location!.lng!), 13);
                                              }else if(selectedPage == SelectedPage.menu){
                                                Navigator.pop(context);
                                              }

                                            });
                                          },
                                        );
                                      }),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
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
                ),
              );
            }
        );
      },
    );
  }
}