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
    var _lang = Provider.of<LocaleProvider>(context, listen: false).locale.toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Consumer<MainPageProvider>(builder: (context, mainPage, _){
        print("SliderWidget -> MainPageProvider");
        return Row(
          mainAxisAlignment: _lang != 'en_US'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (mainPage.slider_state == 0)
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
                          mainPage.setSliderState(1);
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
            else if (mainPage.slider_state == 1)
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
                  children: [
                    TextButton(
                      onPressed: () {
                        mainPage.setSliderState(0);
                      },
                      child: Icon(
                          _lang != 'en_US'
                              ? Icons.arrow_forward_ios_rounded
                              : Icons.arrow_back_ios_rounded,
                          color: Color(0xff00cccc),
                          size: 30),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: 100.0,
                          height:
                          MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.0,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.73,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  color: const Color(0x00000000),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      if (_lang != 'en_US')
                                        Column(
                                          children: [
                                            for (var i = 0; i < categoriesCons().length; i++)
                                              TextButton(
                                                onPressed: () {
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).setFilter(1);
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).setIdCategorySearch(categoriesCons()[i]['id_category']);
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
                                                  if(mainPage.showDiaogSearchDrawer){
                                                    mainPage.setShowDiogFalse();
                                                  }
                                                },
                                                child: Text(
                                                  categoriesCons()[i]['name'],
                                                  style: CustomTextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: const Color(
                                                        0xffffffff),
                                                  ).getTextStyle(),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                              ),
                                          ],
                                        )
                                      else
                                        for (var i = 0; i < enCategoriesCons().length; i++)
                                          Column(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).setFilter(1);
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).setIdCategorySearch(enCategoriesCons()[i]['id_category']);
                                                  Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
                                                  if(mainPage.showDiaogSearchDrawer){
                                                    mainPage.setShowDiogFalse();
                                                  }
                                                },
                                                child: Text(
                                                  enCategoriesCons()[
                                                  i]['name'],
                                                  style: CustomTextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13,
                                                    color: const Color(
                                                        0xffffffff),
                                                  ).getTextStyle(),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
