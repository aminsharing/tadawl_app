import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/constans.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = locale.locale.toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Consumer<MainPageProvider>(builder: (context, mainPage, _){
        return Row(
          mainAxisAlignment: _lang != 'en_US'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!mainPage.slider_state)
              Container(
                width: 80.0,
                height: MediaQuery.of(context).size.height * 0.064,
                decoration: BoxDecoration(
                  boxShadow: [],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: const Color(0xff00cccc),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          mainPage.setSliderState(true);
                        },
                        child: Icon(
                            _lang != 'en_US'
                                ? Icons.arrow_back_ios_rounded
                                : Icons.arrow_forward_ios_rounded,
                            color: Color(0xff1f2835),
                            size: 30),
                      ),
                    ],
                  ),
                ),
              )
            else if (mainPage.slider_state)
              Container(
                width: 100.0,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  boxShadow: [],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: const Color(0xff1f2835),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        mainPage.setSliderState(false);
                      },
                      child: Icon(
                          _lang != 'en_US'
                              ? Icons.arrow_forward_ios_rounded
                              : Icons.arrow_back_ios_rounded,
                          color: Color(0xff00cccc),
                          size: 30),
                    ),
                    Container(
                      width: 100.0,
                      height: MediaQuery.of(context).size.height * 0.72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0x00000000),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: categoriesCons().length,
                        itemBuilder: (context, i){
                          return TextButton(
                            onPressed: () {
                              Provider.of<SearchDrawerProvider>(context, listen: false).setFilter(1);
                              Provider.of<SearchDrawerProvider>(context, listen: false).setIdCategorySearch(categoriesCons()[i]['id_category']);
                              Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
                              if(mainPage.showDiaogSearchDrawer){
                                mainPage.setShowDiogFalse();
                              }
                            },
                            child: Text(
                              _lang != 'en_US'
                                  ?
                              categoriesCons()[i]['name']
                                  :
                              enCategoriesCons()[i]['name'],
                              style: CustomTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: const Color(
                                    0xffffffff),
                              ).getTextStyle(),
                              textAlign:
                              TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },),
    );
  }
}
