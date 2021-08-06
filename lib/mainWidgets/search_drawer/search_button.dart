import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
    @required this.isMainPage
  }) : super(key: key);
  final bool isMainPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
        print("SearchButton -> MainPageProvider");
        print("SearchButton -> MenuProvider");
        return TextButton(
          onPressed: () {
            // _searchDrawerKey.currentState.save();

            if(isMainPage){
              searchDrawer.setFilter(4);
              searchDrawer.getAdsList(context);
            }else{
              searchDrawer.setMenuFilter(4);
              searchDrawer.getMenuList(context);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
              border: Border.all(
                  width: 1.0, color: const Color(0xff00cccc)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context).search,
                        style: CustomTextStyle(
                          fontSize: 20,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        ' ${AppLocalizations.of(context).search}  ${
                            (isMainPage ? searchDrawer.mainAdsCount : searchDrawer.menuAdsCount)??''
                        }  ${AppLocalizations.of(context).advertisement}  ',
                        style: CustomTextStyle(
                          fontSize: 12,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
