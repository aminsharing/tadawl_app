import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/KeySearchModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchAdsProvider extends ChangeNotifier{
  String _search;
  List _KeyData = [];
  final List<KeySearchModel> _key = [];

  void setSearchKey(String value) {
    _search = filterPhone(value);
    notifyListeners();
  }

  void searchKeyInfo(BuildContext context, String keySearch) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().searchKeyFunc(keySearch).then((value) {
        if (value == 'false') {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context).notFoundToast,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0);
        } else {
          _KeyData = value;
          _KeyData.forEach((element) {
            _key.add(KeySearchModel.fromJson(element));
          });
          if (_key.isNotEmpty) {
            if (_key.first.phone == keySearch) {
              // var userMutual = Provider.of<UserMutualProvider>(context, listen: false);
              // userMutual
              //     .getAvatarList(_key.first.phone);
              // userMutual
              //     .getUserAdsList(_key.first.phone);
              // userMutual
              //     .getEstimatesInfo(_key.first.phone);
              // userMutual
              //     .getSumEstimatesInfo(_key.first.phone);
              // userMutual
              //     .checkOfficeInfo(_key.first.phone);
              // userMutual
              //     .setUserPhone(_key.first.phone);
              final locale = Provider.of<LocaleProvider>(context, listen: false);
              // ignore: omit_local_variable_types
              final MyAccountProvider myAccountProvider = MyAccountProvider(locale.phone);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<MyAccountProvider>(
                            create: (_) => myAccountProvider,
                            child: MyAccount(myAccountProvider: myAccountProvider,phone: locale.phone),
                          )
                  )
              );

              // Future.delayed(Duration(seconds: 0), () {
              //   final locale = Provider.of<LocaleProvider>(context, listen: false);
              //   if (userMutual.userPhone == locale.phone){
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               OwenAccount()),
              //     );
              //   }else{
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               OtherAccount()),
              //     );
              //   }
              // });
            }
            else if (_key.first.id_ads == keySearch) {
              // Provider.of<AdPageProvider>(context, listen: false)
              //     .getAllAdsPageInfo(context, _key.first.id_description);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ChangeNotifierProvider<AdPageProvider>(
                        create: (_) => AdPageProvider(context, _key.first.id_description, _key.first.idCategory),
                        child: AdPage(ads: [Provider.of<AdPageProvider>(context, listen: false).adsPage], selectedScreen: SelectedScreen.none),
                      )

                  ),
                );
              });
            }
          }
        }
        notifyListeners();
      });
    });
  }

  String filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      Phone = Phone.toString().replaceFirst('0', '966');
      return Phone;
    } else if (Phone.toString().startsWith('5')) {
      Phone = Phone.toString().replaceFirst('5', '9665');
      return Phone;
    } else if (Phone.toString().startsWith('00')) {
      Phone = Phone.toString().replaceFirst('00', '');
      return Phone;
    } else if (Phone.toString().startsWith('+')) {
      Phone = Phone.toString().replaceFirst('+', '');
      return Phone;
    } else {
      return Phone;
    }
  }



  String get search => _search;
  List<KeySearchModel> get key => _key;

}