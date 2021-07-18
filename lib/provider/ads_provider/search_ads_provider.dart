import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/KeySearchModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
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
      Api().searchKeyFunc(context, keySearch).then((value) {
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
              Provider.of<UserMutualProvider>(context, listen: false)
                  .getAvatarList(context, _key.first.phone);
              Provider.of<UserMutualProvider>(context, listen: false)
                  .getUserAdsList(context, _key.first.phone);
              Provider.of<UserMutualProvider>(context, listen: false)
                  .getEstimatesInfo(context, _key.first.phone);
              Provider.of<UserMutualProvider>(context, listen: false)
                  .getSumEstimatesInfo(context, _key.first.phone);
              Provider.of<UserMutualProvider>(context, listen: false)
                  .checkOfficeInfo(context, _key.first.phone);
              Provider.of<UserMutualProvider>(context, listen: false)
                  .setUserPhone(_key.first.phone);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccount()),
                );
              });
            }
            else if (_key.first.id_ads == keySearch) {
              Provider.of<MutualProvider>(context, listen: false)
                  .getAllAdsPageInfo(context, _key.first.id_description);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdPage()),
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