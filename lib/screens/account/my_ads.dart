import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class MyAds extends StatelessWidget {
  MyAds({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<MyAccountProvider>(builder: (context, myAds, child) {
      return Scaffold(
        backgroundColor: const Color(0xffffffff),
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
            AppLocalizations.of(context).myAds + ' (${myAds.countUserAds()}) ',
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff1f2835),
        ),
        body:
        //if (myAds.userAds.isNotEmpty)
        //for (int i = 0; i < myAds.countUserAds(); i++)
        myAds.userAds.isNotEmpty
            ?
        Directionality(
          textDirection: locale.locale.toString() != 'en_US'
              ?
          TextDirection.ltr
              :
          TextDirection.rtl,

          child: ListView.separated(
            itemCount: myAds.countUserAds(),
            itemBuilder: (context, i){
              return AdButton(
                onPressed: () {
                  //myAds.setWaitState(true);
                  // Provider.of<MutualProvider>(context, listen: false)
                  //     .getAllAdsPageInfo(
                  //     context, myAds.userAds[i].idDescription);
                  // Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, myAds.userAds[i].idCategory, myAds.userAds[i].idDescription);

                  Future.delayed(Duration(seconds: 0), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<AdPageProvider>(
                                create: (_) => AdPageProvider(context, myAds.userAds[i].idDescription, myAds.userAds[i].idCategory),
                                child: AdPage(ads: myAds.userAds, selectedScreen: SelectedScreen.myAds),
                              )

                      ),
                    );
                    // myAds.setWaitState(false);
                  });
                },
                ads_image: myAds.userAds[i].ads_image,
                title: myAds.userAds[i].title,
                idSpecial: myAds.userAds[i].idSpecial,
                price: myAds.userAds[i].price,
                space: myAds.userAds[i].space,
                ads_city: myAds.userAds[i].ads_city,
                ads_neighborhood: myAds.userAds[i].ads_neighborhood,
                ads_road: myAds.userAds[i].ads_road,
                video: myAds.userAds[i].video,
                timeUpdated: myAds.userAds[i].timeUpdated,
                updateBtn: true,
                updateBtnPressed: (){
                  myAds.setNumber(i);
                  myAds.updateAds(context, myAds.userAds[i].idDescription).then((value) {
                    if(value){
                      Fluttertoast.showToast(
                          msg:
                          'تم التحديث بنجاح',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      myAds.getUserAdsList(locale.phone);
                    }
                  }
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: const Color(0xff212a37),
              );
            },
          ),
        )
            :
        Container(),
      );
    });
  }
}
