import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class AdsList extends StatelessWidget {
  const AdsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MyAccountProvider>(builder: (context, avatar, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              width: mediaQuery.size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xffdddddd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    onPressed: (int index) {
                      avatar.updateSelected(index);
                    },
                    isSelected: avatar.isSelected,
                    color: const Color(0xff8d8d8d),
                    selectedColor: const Color(0xff00cccc),
                    fillColor: const Color(0xffdddddd),
                    borderWidth: 2,
                    borderColor: const Color(0xffdddddd),
                    selectedBorderColor: const Color(0xffdddddd),
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(50, 5, 50, 5),
                        child: Text(
                          AppLocalizations.of(context)!.ads +
                              (avatar.userAds.isNotEmpty ? '(${avatar.userAds.length})' : ''),
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(50, 5, 50, 5),
                        child: Text(
                          AppLocalizations.of(context)!.payments,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (avatar.selectedNav == 1)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '...',
                  style: CustomTextStyle(
                    fontSize: 15,
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (avatar.selectedNav == 0)
            Column(
              children: [
                if (avatar.userAds.isNotEmpty)
                  Directionality(
                    textDirection: locale.locale.toString() != 'en_US'
                        ?
                    TextDirection.ltr
                        :
                    TextDirection.rtl,
                    child: Container(
                      height: avatar.countUserAds() * (mediaQuery.size.width*.43),
                      child: ListView.separated(
                        itemCount: avatar.countUserAds(),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i){
                          return AdButton(
                            onPressed: () {
                              Future.delayed(Duration(seconds: 0), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                            AdPageHelper(ads: avatar.userAds, index: i, selectedScreen: SelectedScreen.myAds,)
                                          ),
                                );
                              });
                            },
                            ads_image: avatar.userAds[i].ads_image,
                            title: avatar.userAds[i].title,
                            idSpecial: avatar.userAds[i].idSpecial,
                            price: avatar.userAds[i].price,
                            space: avatar.userAds[i].space,
                            ads_city: avatar.userAds[i].ads_city,
                            ads_neighborhood: avatar.userAds[i].ads_neighborhood,
                            ads_road: avatar.userAds[i].ads_road,
                            video: avatar.userAds[i].video,
                            timeUpdated: avatar.userAds[i].timeUpdated,
                            isUpdating: avatar.userAds[i].isUpdating,
                            updateBtn: true,
                            updateBtnPressed: (){
                              avatar.setNumber(i);
                              avatar.userAds[i].isUpdating = true;
                              avatar.update();
                              avatar.updateAds(context, avatar.userAds[i].idDescription).then((value) {
                                if(value){
                                  Fluttertoast.showToast(
                                      msg:
                                      '???? ?????????????? ??????????',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 15.0);
                                  avatar.getUserAdsList(locale.phone);
                                }
                                avatar.userAds[i].isUpdating = false;
                                avatar.update();
                              });
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: const Color(0xff212a37),
                          );
                        },
                      ),
                    ),
                  )
                else
                  Container(),
              ],
            )
        ],
      );
    });
  }
}
