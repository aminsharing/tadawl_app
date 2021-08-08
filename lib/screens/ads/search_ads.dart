import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/search_ads_provider.dart';

class SearchAds extends StatefulWidget {
  SearchAds({
    Key key,
  }) : super(key: key);
  @override
  _SearchAdsState createState() => _SearchAdsState();
}

class _SearchAdsState extends State<SearchAds> {
  final GlobalKey<FormState> _searchAdsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
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
            AppLocalizations.of(context).speedSearch,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        body: Form(
          key: _searchAdsKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).enterIDAdsOrPhone,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff818181),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<SearchAdsProvider>(builder: (context, searchFast, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mediaQuery.size.width * 0.6,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context).enterHere),
                                style: CustomTextStyle(

                                  fontSize: 13,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                keyboardType: TextInputType.number,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context).notFound;
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  searchFast.setSearchKey(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SizedBox(
                                width: mediaQuery.size.width * 0.1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: Color(0xff00cccc),
                                    size: 40,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                        child: TextButton(
                          onPressed: () {
                            if (!_searchAdsKey.currentState.validate()) {
                              return;
                            }
                            _searchAdsKey.currentState.save();
                            searchFast.searchKeyInfo(context, searchFast.search);
                          },
                          child: Container(
                            width: mediaQuery.size.width * 0.6,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xffffffff),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xff3f9d28)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context).search,
                                  style: CustomTextStyle(
                                    fontSize: 20,
                                    color: const Color(0xff3f9d28),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
  }
}
