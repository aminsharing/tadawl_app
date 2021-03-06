import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/advertising_fees_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';


class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, required this.addAdProvider, required this.firstContext}) : super(key: key);

  final AddAdProvider addAdProvider;
  final BuildContext firstContext;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    Future<bool> _onBackPressed() async{
        return showDialog<bool>(
          context: context,
          builder: (ctxt) =>
              AlertDialog(
                title: Text(
                  'إلغاء نشر الإعلان',
                  style: CustomTextStyle(
                    fontSize: 20,
                    color: const Color(0xff04B404),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  'هل تريد إلغاء نشر الإعلان، بموافقتك سوف تفقد أية معلومات متعلقة بالإعلان؟',
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(ctxt).pop(true);
                      Navigator.pop(firstContext);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage()
                          )
                      );
                      // Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Text(
                        'نعم',
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(ctxt).pop(false),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Text(
                        'لا',
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
        ).then((value) => value??false);
      }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 70.0,
          backgroundColor: const Color(0xff1f2835),
          title: Center(
            widthFactor: 2.5,
            child: Text(
              AppLocalizations
                  .of(context)!
                  .chooseCategory,
              style: CustomTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
              size: 40,
            ),
            onPressed: _onBackPressed,
          ),
        ),
        body: ChangeNotifierProvider<AddAdProvider>.value(
          value: addAdProvider,
          builder: (context, _){
            return Consumer<AddAdProvider>(builder: (context, addAds, child) {
              return addAds.categoryAddAds.isNotEmpty
                  ?
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height,
                  child: ListView.builder(
                    itemCount: addAds.categoryAddAds.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, i){
                      return TextButton(
                        onPressed: () {
                          addAds.updateCategoryDetailsAddAds(
                              int.parse(addAds.categoryAddAds[i].id_category!),
                              addAds.categoryAddAds[i].name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdvertisingFeesScreen(addAdProvider),
                              )
                          );
                        },
                        child: Container(
                          width: mediaQuery.size.width,
                          height: 70,
                          decoration: BoxDecoration(
                            color: '${addAds.id_category_finalAddAds}' == addAds.categoryAddAds[i].id_category ? Color(0xff04B404) : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _lang != 'en_US'
                                      ? addAds.categoryAddAds[i].name!
                                      : addAds.categoryAddAds[i].en_name!,
                                  style: CustomTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: '${addAds.id_category_finalAddAds}' == addAds.categoryAddAds[i].id_category ? Colors.white : Color(0xff04B404),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: '${addAds.id_category_finalAddAds}' == addAds.categoryAddAds[i].id_category ? Colors.grey[200] : Color(0xff04B404),
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
                  :
              Container();
            });
          },
        ),
      ),
    );
  }
}
