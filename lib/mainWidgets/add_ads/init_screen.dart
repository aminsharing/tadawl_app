import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/add_ads/category_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';


class InitScreen extends StatelessWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async{
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage()
            )
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
          backgroundColor: const Color(0xff1f2835),
          title: Center(
            widthFactor: 1.5,
            child: Text(
              AppLocalizations.of(context).addAdsCond,
              style: CustomTextStyle(
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
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage()
                  )
              );
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context).rule26,
                      style: CustomTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black,
                      ).getTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // addAds.setCurrentStageAddAds(1);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryScreen(),));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  width: mediaQuery.size.width * 0.6,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffffffff),
                    border: Border.all(
                        width: 1.0, color: const Color(0xff3f9d28)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .accept,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff3f9d28),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
