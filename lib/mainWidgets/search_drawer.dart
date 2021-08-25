import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/choose_category.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/search_button.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/search_field.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/search_filter.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/two_weeks_switch.dart';
import 'package:tadawl_app/mainWidgets/search_on_map.dart';
import 'package:tadawl_app/provider/ads_provider/search_ads_provider.dart';
import 'package:tadawl_app/screens/ads/search_ads.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({
    Key key,
    @required this.selectedPage
  }) : super(key: key);
  final SelectedPage selectedPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 75.0,
              decoration: BoxDecoration(
                color: const Color(0xff1f2835),
                border: Border.all(width: 1.0, color: const Color(0xff818181)),
              ),
            ),
            // top cyan bar .................................
            SearchField(selectedPage: selectedPage,),
            // choose location ..............................
            ChooseCategory(),
            // choose category ..............................
            SearchFilter(),

            SearchButton(selectedPage: selectedPage,),
            // search button ................................
            TwoWeeksSwitch(selectedPage: selectedPage,),
            // two weeks ago switch .........................
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ChangeNotifierProvider<SearchAdsProvider>(
                          create: (_) => SearchAdsProvider(),
                          child: SearchAds(),
                        )
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffffffff),
                    border: Border.all(
                        width: 1.0, color: const Color(0xff04B404)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).speedSearch,
                          style: CustomTextStyle(

                            fontSize: 17,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xff04B404),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // quick search button ..........................
          ],
        ),
      ),
    );
  }
}
