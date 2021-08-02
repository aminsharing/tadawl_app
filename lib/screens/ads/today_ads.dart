import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/today_ads/today_ads_card.dart';
import 'package:tadawl_app/provider/ads_provider/today_ads_provider.dart';

class TodayAds extends StatelessWidget {
  TodayAds({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodayAdsProvider>(builder: (context, todayAds, child) {

      print("TodayAds -> TodayAdsProvider");

      var mediaQuery = MediaQuery.of(context);
      //todayAds.getTodayAdsList(context);
      //todayAds.randomPosition(50);

      return Scaffold(
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
            AppLocalizations.of(context).todayAds +
                ' (${todayAds.countTodayAds()}) ',
            style: CustomTextStyle(
              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(context).riyadh,
                            style: CustomTextStyle(
                              fontSize: 13,
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(context).makkah,
                            style: CustomTextStyle(

                              fontSize: 13,
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(context).esternRegion,
                            style: CustomTextStyle(

                              fontSize: 13,
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(context).rest,
                            style: CustomTextStyle(

                              fontSize: 13,
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      onPressed: (int index) {
                        todayAds.updateSelected5(index);
                      },
                      isSelected: todayAds.isSelected5,
                      color: const Color(0xff00cccc),
                      selectedColor: const Color(0xffffffff),
                      fillColor: const Color(0xff00cccc),
                      borderColor: const Color(0xff00cccc),
                      borderWidth: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.70,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (todayAds.filterCity == null ||
                          todayAds.filterCity == 1)
                        Column(
                          children: [
                            if (todayAds.todayAds.isNotEmpty)
                              for (int i = 0; i < todayAds.countTodayAds(); i++)
                                if (todayAds.todayAds[i].ads_city == 'الرياض')
                                  TodayAdsCard(todayAds: todayAds.todayAds[i]),
                            if (todayAds.countAdsRiyadh > 0) Container()
                            else Center(child: Text(
                              AppLocalizations.of(context).noAdsAvailable,
                              style: CustomTextStyle(
                                fontSize: 12,
                                color: const Color(
                                    0xff000000),
                              ).getTextStyle(),
                            ),),

                          ],
                        )
                      else if (todayAds.filterCity == 2)
                        Column(
                          children: [
                            if (todayAds.todayAds.isNotEmpty)
                              for (int i = 0; i < todayAds.countTodayAds(); i++)
                                if (todayAds.todayAds[i].ads_city == 'مكة')
                                  TodayAdsCard(todayAds: todayAds.todayAds[i]),

                            if (todayAds.countAdsMekkah > 0) Container()
                            else Center(child: Text(
                              AppLocalizations.of(context).noAdsAvailable,
                              style: CustomTextStyle(
                                fontSize: 12,
                                color: const Color(
                                    0xff000000),
                              ).getTextStyle(),
                            ),),

                          ],
                        )
                      else if (todayAds.filterCity == 3)
                        Column(
                          children: [
                            if (todayAds.todayAds.isNotEmpty)
                              for (int i = 0; i < todayAds.countTodayAds(); i++)
                                if (todayAds.todayAds[i].ads_city == 'الدمام')
                                  TodayAdsCard(todayAds: todayAds.todayAds[i]),

                            if (todayAds.countAdsDammam > 0) Container()
                            else Center(child: Text(
                              AppLocalizations.of(context).noAdsAvailable,
                              style: CustomTextStyle(
                                fontSize: 12,
                                color: const Color(
                                    0xff000000),
                              ).getTextStyle(),
                            ),),

                          ],
                        )
                      else if (todayAds.filterCity == 4)
                        Column(
                          children: [
                            if (todayAds.todayAds.isNotEmpty)
                              for (int i = 0; i < todayAds.countTodayAds(); i++)
                                if (todayAds.todayAds[i].ads_city != 'الدمام' &&
                                    todayAds.todayAds[i].ads_city != 'مكة' &&
                                    todayAds.todayAds[i].ads_city != 'الرياض')
                                  TodayAdsCard(todayAds: todayAds.todayAds[i]),
                            if (todayAds.countAdsRest > 0)
                              Container()
                            else
                              Center(child: Text(
                              AppLocalizations.of(context).noAdsAvailable,
                              style: CustomTextStyle(
                                fontSize: 12,
                                color: const Color(
                                    0xff000000),
                              ).getTextStyle(),
                            ),),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
