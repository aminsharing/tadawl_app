import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/discussion_list.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/screens/ads/menu.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';
import 'package:tadawl_app/screens/general/regions.dart';

class BottomNavigationBarApp extends StatelessWidget {
  BottomNavigationBarApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final local = Provider.of<LocaleProvider>(context, listen: false);
    // ignore: omit_local_variable_types
    final MsgProvider msgProvider = MsgProvider(local.phone, null);



    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: mediaQuery.size.height * 0.11,
        width: mediaQuery.size.width,
        color: const Color(0xff212a37),
        child: Consumer<BottomNavProvider>(builder: (ctxt, btmNav, child){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Scaffold.of(context).openEndDrawer();
                      Scaffold.of(context).openDrawer();
                      // Provider.of<AdsProvider>(context, listen: false).update();
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff1f2835),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Color(0xffffffff),
                              size: 25,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).myAccount,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: const Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage == 0){
                        // mainPageProv.animateLocation(context);
                      }else{
                        btmNav.setCurrentPage(0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(null)),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff2d3872), width: 1),
                            color: btmNav.currentPage == 0 ? const Color(0xff04B404) : const Color(0xff1f2835),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xffffffff),
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .myLocation,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 0 ? const Color(0xff04B404) :  Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage != 1){
                        btmNav.setCurrentPage(1);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Regions()),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff2d3872), width: 1),
                            color: btmNav.currentPage == 1 ? const Color(0xff04B404) : const Color(0xff1f2835),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.map,
                              color: Color(0xffffffff),
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .regions,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 1 ? const Color(0xff04B404) : Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async{
                      if(btmNav.currentPage != 2){
                        btmNav.setCurrentPage(2);
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RealEstateOffices()),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff2d3872), width: 1),
                            color: btmNav.currentPage == 2 ? const Color(0xff04B404) : const Color(0xff1f2835),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.home_work,
                              color: Color(0xffffffff),
                              size: 24,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            AppLocalizations
                                .of(context)
                                .realEstateOffices,
                            style: CustomTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: btmNav.currentPage == 2 ? const Color(0xff04B404) : Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      final locale = Provider.of<LocaleProvider>(context, listen: false);
                      if(locale.phone != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChangeNotifierProvider<MsgProvider>(
                              create: (_) => msgProvider,
                              child: DiscussionList(msgProvider: msgProvider),
                            )
                        ),
                        );
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login(),)
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff2d3872), width: 1),
                                  color: btmNav.currentPage == 3 ? const Color(0xff04B404) : const Color(0xff1f2835),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.message_rounded,
                                    color: Color(0xffffffff),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            // if(msgProv.unreadMsgs != 0)
                            //   Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Container(
                            //       width: 15.0,
                            //       height: 15.0,
                            //       decoration:
                            //       BoxDecoration(
                            //           color: Colors
                            //               .red
                            //               .withOpacity(
                            //               0.8),
                            //           shape: BoxShape
                            //               .circle),
                            //       child: Center(
                            //         child: Text(
                            //           '${msgProv.unreadMsgs}',
                            //           style: TextStyle(
                            //             fontFamily:
                            //             'DINNext',
                            //             fontSize: 11,
                            //             color: Colors.white,
                            //             // color:
                            //             // convList.conv[i].phone_user_sender == _phone
                            //             //         ? Color(0xff848282)
                            //             //         : Color(0xffffffff),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            AppLocalizations
                                .of(context)
                                .messages,
                            style: CustomTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: btmNav.currentPage == 3 ? const Color(0xff04B404) : Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage != 4){
                        btmNav.setCurrentPage(4);
                        Navigator.pushReplacement(
                          context,
                            MaterialPageRoute(builder: (context) => ChangeNotifierProvider<MenuProvider>(
                              create: (_) => MenuProvider(),
                              child: ChangeNotifierProvider<SearchDrawerProvider>(
                                create: (_) => SearchDrawerProvider(),
                                child: Menu(),
                              ),
                            ),)
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff2d3872), width: 1),
                            color: btmNav.currentPage == 4 ? const Color(0xff04B404) : const Color(0xff1f2835),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.menu,
                              color: Color(0xffffffff),
                              size: 24,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).menu,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 4 ? const Color(0xff04B404) : Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
