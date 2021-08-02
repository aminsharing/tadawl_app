import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/maps/real_estate_map.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tadawl_app/provider/office_marker_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/offices_Vr.dart';

class RealEstateOffices extends StatelessWidget {
  RealEstateOffices({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserMutualProvider>(context, listen: false).getSession();
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(
                AppLocalizations
                    .of(context)
                    .closeApp,
                style: CustomTextStyle(

                  fontSize: 20,
                  color: const Color(0xff00cccc),
                ).getTextStyle(),
                textAlign: TextAlign.right,
              ),
              content: Text(
                AppLocalizations
                    .of(context)
                    .areYouSureCloseApp,
                style: CustomTextStyle(

                  fontSize: 17,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.right,
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .yes,
                      style: CustomTextStyle(

                        fontSize: 17,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .no,
                      style: CustomTextStyle(

                        fontSize: 17,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
      ) ??
          false;
    }

    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        endDrawer: Container(),
        body: Stack(
          children: <Widget>[
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              color: Color(0xffffffff),
              child: Center(
                child: ChangeNotifierProvider<OfficeMarkerProvider>(
                  create: (_) => OfficeMarkerProvider(),
                  child: RealEstateMap(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                mainAxisAlignment: _lang != 'en_US'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (_phone != null) {
                        Navigator.push(context,
                          PageTransition(type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 10),
                              child: OfficesVR()),
                        );
                      }
                      else {
                        Navigator.push(context,
                          PageTransition(type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 10),
                              child: Login()),
                        );
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.46,
                      height: mediaQuery.size.height * 0.09,
                      decoration: BoxDecoration(
                        boxShadow: [],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: const Color(0xff00cccc),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      AppLocalizations.of(context).officesAccreditation,
                                      style: CustomTextStyle(
                                        fontSize: _lang != 'en_US' ? mediaQuery.size.width * .035 >= 13 ? 13 : mediaQuery.size.width * .035 : mediaQuery.size.width * .035 >= 13 ? 13 : mediaQuery.size.width * .035,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Icon(
                                          Icons.verified_user_rounded,
                                          color: Color(0xffffffff),
                                          size: mediaQuery.size.width * .085 >= 30 ? 30 : mediaQuery.size.width * .085,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              AppLocalizations.of(context).officesAccreditation2,
                              style: CustomTextStyle(
                                fontSize: _lang != 'en_US' ? mediaQuery.size.width * .035 >= 13 ? 13 : mediaQuery.size.width * .035 : mediaQuery.size.width * .035 >= 13 ? 13 : mediaQuery.size.width * .035,
                                color: const Color(0xffe6e600),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: mediaQuery.size.height * 0.11,
            child: BottomNavigationBarApp()),
      ),
    );
  }
}
