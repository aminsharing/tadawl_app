import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/test/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Favourite extends StatelessWidget {
  Favourite({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, adsFav, child) {

      Provider.of<MutualProvider>(context, listen: false).randomPosition(50);
      var mediaQuery = MediaQuery.of(context);
      adsFav.getSession();
      var _phone = adsFav.phone;
      adsFav.getUserAdsFavList(context, _phone);

      Future<Null> _refresh() async{
        var _phone = adsFav.phone;
        adsFav.getUserAdsFavList(context, _phone);
        adsFav.update();
      }

      return RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          appBar: AppBar(
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
          body: Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height * .9,
            child: ListView.builder(
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
                    return TextButton(
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
                      child: Container(
                        width: mediaQuery.size.width,
                        height: 150.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffa6a6a6),
                              offset: const Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 7.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(children: [
                              Container(
                                width: 180.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        'https://tadawl.com.sa/API/assets/images/ads/' +
                                            adsFav.userAdsFav[i]
                                                .ads_image ??
                                            ''),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    Provider.of<MutualProvider>(context,
                                        listen: false)
                                        .randdLeft,
                                    Provider.of<MutualProvider>(context,
                                        listen: false)
                                        .randdTop,
                                    5,
                                    5),
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const CachedNetworkImageProvider(
                                            'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (adsFav.userAdsFav[i].idSpecial ==
                                          '1')
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 10, 0),
                                          child: Icon(
                                            Icons.verified,
                                            color: Color(0xffe6e600),
                                            size: 30,
                                          ),
                                        ),
                                      Text(
                                        adsFav.userAdsFav[i].title,
                                        style: CustomTextStyle(
                                          fontSize: 20,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        adsFav.userAdsFav[i].price,
                                        style: CustomTextStyle(
                                          fontSize: 15,
                                          color: const Color(0xff00cccc),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.right,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: Text(
                                          AppLocalizations.of(context).rial,
                                          style: CustomTextStyle(
                                            fontSize: 15,
                                            color: const Color(0xff00cccc),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        adsFav.userAdsFav[i].space,
                                        style: CustomTextStyle(
                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.right,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: Text(
                                          AppLocalizations.of(context).m2,
                                          style: CustomTextStyle(
                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        if (adsFav
                                            .userAdsFav[i].video.isNotEmpty)
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Icon(
                                              Icons.videocam_outlined,
                                              color: Color(0xff00cccc),
                                              size: 30,
                                            ),
                                          ),
                                        if (adsFav.userAdsFav[i].ads_city !=
                                            null ||
                                            adsFav.userAdsFav[i]
                                                .ads_neighborhood !=
                                                null)
                                          Text(
                                            '${adsFav.userAdsFav[i].ads_city} - ${adsFav.userAdsFav[i].ads_neighborhood}',
                                            style: CustomTextStyle(
                                              fontSize: 8,
                                              color: const Color(0xff000000),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.right,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
                return Container();
              },
            ),
          )
        ),
      );
    });
  }
}
