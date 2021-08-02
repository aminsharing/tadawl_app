import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class Constants {
  static const String editGallery = 'تعديل الصور والفيديو';
  static const String editLocation = 'تعديل الموقع';
  static const String editDetails = 'تعديل التفاصيل';
  static const String deleteAd = 'حذف الإعلان';
  static const List<String> choices = <String>[
    editGallery,
    editLocation,
    editDetails,
    deleteAd,
  ];
}

class EngConstants {
  static const String editGallery = 'Update Images and Videos';
  static const String editLocation = 'Update Location';
  static const String editDetails = 'Update Details';
  static const String deleteAd = 'Delete Ad';
  static const List<String> choices = <String>[
    editGallery,
    editLocation,
    editDetails,
    deleteAd,
  ];
}

class AppBarActionWidget extends StatelessWidget {
  AppBarActionWidget({Key key, this.adsPage}) : super(key: key);
  final MutualProvider adsPage;



  @override
  Widget build(BuildContext context) {
    var _lang = Provider.of<LocaleProvider>(context, listen: false).locale.toString();
    final adPageProv = Provider.of<AdPageProvider>(context, listen: false);
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

    return adsPage.adsUser.isNotEmpty
        ? adsPage.adsUser.first.phone == _phone
        ?
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.edit,
          color: Color(0xffffffff),
          size: 40,
        ),
        onSelected: (String choice) {
          adPageProv.choiceAction(context, choice, adsPage.idDescription);
        },
        itemBuilder: (BuildContext context) {
          if (_lang != 'en_US') {
            return Constants.choices.map((String choice) {
              if (choice == Constants.deleteAd) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xffff0000),
                    ).getTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                );
              } else {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xff989898),
                    ).getTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                );
              }
            }).toList();
          } else {
            return EngConstants.choices
                .map((String choice) {
              if (choice == EngConstants.deleteAd) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xffff0000),
                    ).getTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                );
              } else {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xff989898),
                    ).getTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                );
              }
            }).toList();
          }
        },
      ),
    )
        : Container()
        : Container();
  }
}
