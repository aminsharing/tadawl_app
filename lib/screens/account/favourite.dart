import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class Favourite extends StatelessWidget {
  Favourite({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<FavouriteProvider>(builder: (context, adsFav, child) {


      // Provider.of<MutualProvider>(context, listen: false).randomPosition(50);
      var mediaQuery = MediaQuery.of(context);

      // adsFav.getUserAdsFavList(locale.phone);

      Future<Null> _refresh() async{
        await adsFav.getUserAdsFavList(locale.phone);
        adsFav.update();
      }

      return RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          appBar: AppBar(
          centerTitle: true,
            toolbarHeight: 80.0,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffffffff),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              AppLocalizations.of(context).favourite,
              style: CustomTextStyle(

                fontSize: 20,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff00cccc),
          ),
          backgroundColor: const Color(0xffffffff), // adsFav.countUserAdsFav()
          body: Directionality(
            textDirection: locale.locale.toString() != 'en_US'
                ?
            TextDirection.ltr
                :
            TextDirection.rtl,
            child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * .9,
              child: ListView.separated(
                itemCount: adsFav.countUserAdsFav(),
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i){
                  if(adsFav.userAdsFav.isEmpty){
                    if(i == adsFav.countUserAdsFav() - 1){
                      return Container(child: Center(child: Text('No Ads'),),);
                    }
                  }
                  else{
                    if (adsFav.userAdsFav[i].isFav == '1') {
                      return AdButton(
                          onPressed: () {
                            Provider.of<MutualProvider>(context, listen: false)
                                .getAllAdsPageInfo(context, adsFav.userAdsFav[i].idDescription);
                            Provider.of<MutualProvider>(context, listen: false)
                                .getSimilarAdsList(context, adsFav.userAdsFav[i].idCategory, adsFav.userAdsFav[i].idDescription);

                            Future.delayed(Duration(seconds: 0), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AdPage()),
                              );
                            });
                          },
                          ads_image: adsFav.userAdsFav[i].ads_image,
                          title: adsFav.userAdsFav[i].title,
                          idSpecial: adsFav.userAdsFav[i].idSpecial,
                          price: adsFav.userAdsFav[i].price,
                          space: adsFav.userAdsFav[i].space,
                          ads_city: adsFav.userAdsFav[i].ads_city,
                          ads_neighborhood: adsFav.userAdsFav[i].ads_neighborhood,
                          ads_road: adsFav.userAdsFav[i].ads_road,
                          video: adsFav.userAdsFav[i].video,
                      );
                    } else {
                      return Container();
                    }
                  }
                  return Container();
                }, separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: const Color(0xff212a37),
                );
              },
              ),
            ),
          )
        ),
      );
    });
  }
}
