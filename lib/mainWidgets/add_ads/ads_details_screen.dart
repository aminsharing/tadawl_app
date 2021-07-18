import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/ads_price_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';


class AdsDetailsScreen extends StatelessWidget {
  const AdsDetailsScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    Future<bool> _onInterfaceCheck() {
      return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: Text(
                AppLocalizations
                    .of(context)
                    .reqInterface,
                style: CustomTextStyle(

                  fontSize: 17,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.right,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .accept,
                      style: CustomTextStyle(

                        fontSize: 17,
                        color: const Color(0xff00cccc),
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
    return Consumer<AddAdProvider>(builder: (context, addAds, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff00cccc),
          title: Center(
            widthFactor: 1.3,
            child: Text(
              AppLocalizations
                  .of(context)
                  .addAdsDetails,
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
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (addAds.id_category_finalAddAds == 1 ||
                  addAds.id_category_finalAddAds == 2 ||
                  addAds.id_category_finalAddAds == 3 ||
                  addAds.id_category_finalAddAds == 4 ||
                  addAds.id_category_finalAddAds == 5 ||
                  addAds.id_category_finalAddAds == 6 ||
                  addAds.id_category_finalAddAds == 7 ||
                  addAds.id_category_finalAddAds == 8 ||
                  addAds.id_category_finalAddAds == 9 ||
                  addAds.id_category_finalAddAds == 10 ||
                  addAds.id_category_finalAddAds == 11 ||
                  addAds.id_category_finalAddAds == 12 ||
                  addAds.id_category_finalAddAds == 13 ||
                  addAds.id_category_finalAddAds == 14 ||
                  addAds.id_category_finalAddAds == 15 ||
                  addAds.id_category_finalAddAds == 16 ||
                  addAds.id_category_finalAddAds == 17 ||
                  addAds.id_category_finalAddAds == 18 ||
                  addAds.id_category_finalAddAds == 19 ||
                  addAds.id_category_finalAddAds == 20 ||
                  addAds.id_category_finalAddAds == 21)
              //    toggle .............. 4 ......................
                Column(
                  children: [
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 2 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 7 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 10 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 15 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 18 ||
                        addAds.id_category_finalAddAds == 19 ||
                        addAds.id_category_finalAddAds == 21)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations
                                        .of(context)
                                        .interface,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff000000),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey),
                                  borderRadius:
                                  BorderRadius.circular(0)),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      AppLocalizations
                                          .of(context)
                                          .interface,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color:
                                        const Color(0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    value: addAds
                                        .interfaceSelectedAddAds ??
                                        '1',
                                    onChanged: (String newValue) {
                                      addAds
                                          .setInterfaceSelectedAddAds(
                                          newValue);
                                    },
                                    items: _lang != 'en_US'
                                        ? Provider.of<MainPageProvider>(context, listen: false).Interface.map(
                                            (Map map) {
                                          return DropdownMenuItem<String>(
                                            value: map['id_type'].toString(),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    map['type'],
                                                    style:
                                                    CustomTextStyle(
                                                      fontSize: 15,
                                                      color: const Color(
                                                          0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList()
                                        : Provider.of<MainPageProvider>(context, listen: false).EnInterface.map(
                                            (Map map) {
                                          return DropdownMenuItem<
                                              String>(
                                            value: map['id_type']
                                                .toString(),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    map['type'],
                                                    style:
                                                    CustomTextStyle(
                                                      fontSize: 15,
                                                      color: const Color(
                                                          0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 2 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 10 ||
                        addAds.id_category_finalAddAds == 11)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButtons(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 0, 30, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .commHousing,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 0, 30, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .commercial,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 0, 30, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .housing,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                addAds.setTyprAqarAddAds(index);
                              },
                              isSelected: addAds.typeAqarAddAds,
                              color: const Color(0xff00cccc),
                              selectedColor: const Color(0xffffffff),
                              fillColor: const Color(0xff00cccc),
                              borderColor: const Color(0xff00cccc),
                              selectedBorderColor:
                              const Color(0xff00cccc),
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 14)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButtons(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      66, 0, 66, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .single,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      66, 0, 66, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .family,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                addAds.setFamilyAddAds(index);
                              },
                              isSelected: addAds.familyAddAds,
                              color: const Color(0xff00cccc),
                              selectedColor: const Color(0xffffffff),
                              fillColor: const Color(0xff00cccc),
                              borderColor: const Color(0xff00cccc),
                              selectedBorderColor:
                              const Color(0xff00cccc),
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 17 ||
                        addAds.id_category_finalAddAds == 20)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButtons(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      37, 0, 37, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .daily,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      37, 0, 37, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .monthly,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      37, 0, 37, 0),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .annual,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                addAds.setPlanAddAds(index);
                              },
                              isSelected: addAds.planAddAds,
                              color: const Color(0xff00cccc),
                              selectedColor: const Color(0xffffffff),
                              fillColor: const Color(0xff00cccc),
                              borderColor: const Color(0xff00cccc),
                              selectedBorderColor:
                              const Color(0xff00cccc),
                              borderWidth: 1,
                            ),
                          ],
                        ),
                      ),
// ....... end toggle ......
// sliders .............. 11 .................

                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .lounges,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.LoungesAddAds == 5)
                              Text(
                                '+5',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                addAds.LoungesAddAds.floor()
                                    .toString(),
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),

                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.LoungesAddAds,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: addAds.LoungesAddAds.floor()
                            .toString(),
                        onChanged: (double value) {
                          addAds.setLoungesAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .toilets,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.ToiletsAddAds == 5)
                              Text(
                                '+5',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                addAds.ToiletsAddAds.floor()
                                    .toString(),
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.ToiletsAddAds,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: addAds.ToiletsAddAds.floor()
                            .toString(),
                        onChanged: (double value) {
                          addAds.setToiletsAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 2 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 7 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 10 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 18 ||
                        addAds.id_category_finalAddAds == 19 ||
                        addAds.id_category_finalAddAds == 21)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .streetWidth,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              addAds.StreetWidthAddAds.floor()
                                  .toString(),
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 2 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 7 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 10 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 18 ||
                        addAds.id_category_finalAddAds == 19 ||
                        addAds.id_category_finalAddAds == 21)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.StreetWidthAddAds,
                        min: 0,
                        max: 99,
                        divisions: 99,
                        label: addAds.StreetWidthAddAds.floor()
                            .toString(),
                        onChanged: (double value) {
                          addAds.setStreetWidthAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .rooms,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.RoomsAddAds == 5)
                              Text(
                                '+5',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                addAds.RoomsAddAds.floor().toString(),
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),

                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.RoomsAddAds,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: addAds.RoomsAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setRoomsAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .apartments,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.ApartmentsAddAds == 30)
                              Text(
                                '+30',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              Text(
                                addAds.ApartmentsAddAds.floor()
                                    .toString(),
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.ApartmentsAddAds,
                        min: 0,
                        max: 30,
                        divisions: 30,
                        label: addAds.ApartmentsAddAds.floor()
                            .toString(),
                        onChanged: (double value) {
                          addAds.setApartementsAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .floor,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.FloorAddAds == 0)
                              Text(
                                AppLocalizations
                                    .of(context)
                                    .undefined,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              if (addAds.FloorAddAds == 1)
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .groundFloor,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff000000),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                )
                              else
                                if (addAds.FloorAddAds == 2)
                                  Text(
                                    AppLocalizations
                                        .of(context)
                                        .first,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff000000),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  )
                                else
                                  if (addAds.FloorAddAds == 20)
                                    Text(
                                      '+20',
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(
                                            0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    )
                                  else
                                    Text(
                                      addAds.FloorAddAds.floor()
                                          .toString(),
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(
                                            0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.FloorAddAds,
                        min: 0,
                        max: 20,
                        divisions: 20,
                        label: addAds.FloorAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setFloorAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 7 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 17 ||
                        addAds.id_category_finalAddAds == 18 ||
                        addAds.id_category_finalAddAds == 19 ||
                        addAds.id_category_finalAddAds == 21)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .ageOfRealEstate,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            if (addAds.AgeOfRealEstateAddAds == -1)
                              Text(
                                AppLocalizations
                                    .of(context)
                                    .undefined,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              )
                            else
                              if (addAds.AgeOfRealEstateAddAds ==
                                  0)
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .lessYear,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff000000),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                )
                              else
                                if (addAds.AgeOfRealEstateAddAds ==
                                    35)
                                  Text(
                                    '+35',
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff000000),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  )
                                else
                                  Text(
                                    addAds.AgeOfRealEstateAddAds
                                        .floor()
                                        .toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff000000),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 7 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 17 ||
                        addAds.id_category_finalAddAds == 18 ||
                        addAds.id_category_finalAddAds == 19 ||
                        addAds.id_category_finalAddAds == 21)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.AgeOfRealEstateAddAds,
                        min: 0,
                        max: 36,
                        divisions: 36,
                        label: addAds.AgeOfRealEstateAddAds.floor()
                            .toString(),
                        onChanged: (double value) {
                          addAds.setAgeOfREAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .stores,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              addAds.StoresAddAds.floor().toString(),
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.StoresAddAds,
                        min: 0,
                        max: 50,
                        divisions: 50,
                        label: addAds.StoresAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setStoresAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .rooms,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              addAds.RoomsAddAds.floor().toString(),
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                    if (addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 11)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.RoomsAddAds,
                        min: 0,
                        max: 9999,
                        divisions: 9999,
                        label: addAds.RoomsAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setRoomsAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 6 ||
                        addAds.id_category_finalAddAds == 13)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .trees,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              addAds.TreesAddAds.floor().toString(),
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 6 ||
                        addAds.id_category_finalAddAds == 13)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.TreesAddAds,
                        min: 0,
                        max: 9999,
                        divisions: 9999,
                        label: addAds.TreesAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setTreesAddAds(value);
                        },
                      ),
                    if (addAds.id_category_finalAddAds == 6 ||
                        addAds.id_category_finalAddAds == 13)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .wells,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              addAds.WellsAddAds.floor().toString(),
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                    if (addAds.id_category_finalAddAds == 6 ||
                        addAds.id_category_finalAddAds == 13)
                      Slider(
                        activeColor: const Color(0xff00cccc),
                        value: addAds.WellsAddAds,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: addAds.WellsAddAds.floor().toString(),
                        onChanged: (double value) {
                          addAds.setWellsAddAds(value);
                        },
                      ),
//........end sliders...........
// switches ................... 18 ..................
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .hallStaircase,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isHallStaircaseAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsHallStaircaseAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .driverRoom,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isDriverRoomAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsDriverRoomAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .maidRoom,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isMaidRoomAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsMaidRoomAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .swimmingPool,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isSwimmingPoolAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsSwimmingPoolAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 12)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .footballCourt,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isFootballCourtAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsFootballCourtAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 12)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .volleyballCourt,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isVolleyballCourtAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds
                                    .setIsVolleyballCourtAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 3 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 11 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15 ||
                        addAds.id_category_finalAddAds == 16 ||
                        addAds.id_category_finalAddAds == 17)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .furnished,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isFurnishedAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsFurnishedAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 6 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .verse,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isVerseAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsVerseAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .yard,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isMonstersAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsMonstersAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 17)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .kitchen,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isKitchenAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsKitchenAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 14)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .appendix,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isAppendixAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsAppendixAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 4 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .carEntrance,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isCarEntranceAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsCarEntranceAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .cellar,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isCellarAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsCellarAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 8 ||
                        addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 14)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .elevator,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isElevatorAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsElevatorAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 1 ||
                        addAds.id_category_finalAddAds == 9)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .duplex,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isDuplexAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsDuplexAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 9 ||
                        addAds.id_category_finalAddAds == 14 ||
                        addAds.id_category_finalAddAds == 15)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .conditioner,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isConditionerAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsConditionerAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 12)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .amusementPark,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isAmusementParkAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds.setIsAmusementParkAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (addAds.id_category_finalAddAds == 5 ||
                        addAds.id_category_finalAddAds == 12 ||
                        addAds.id_category_finalAddAds == 20)
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .familyPartition,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            FlutterSwitch(
                              activeColor: const Color(0xff00cccc),
                              width: 40.0,
                              height: 20.0,
                              valueFontSize: 15.0,
                              toggleSize: 15.0,
                              value: addAds.isFamilyPartitionAddAds,
                              borderRadius: 15.0,
                              padding: 2.0,
                              showOnOff: false,
                              onToggle: (val) {
                                addAds
                                    .setIsFamilyPartitionAddAds(val);
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
//........end switches...........
//..............................
              TextButton(
                onPressed: () {
                  // if (!addAdsKey.currentState.validate()) {
                  //   return;
                  // }
                  // addAdsKey.currentState.save();
                  if ((addAds.id_category_finalAddAds == 1 ||
                      addAds.id_category_finalAddAds == 2 ||
                      addAds.id_category_finalAddAds == 3 ||
                      addAds.id_category_finalAddAds == 4 ||
                      addAds.id_category_finalAddAds == 5 ||
                      addAds.id_category_finalAddAds == 7 ||
                      addAds.id_category_finalAddAds == 8 ||
                      addAds.id_category_finalAddAds == 9 ||
                      addAds.id_category_finalAddAds == 10 ||
                      addAds.id_category_finalAddAds == 11 ||
                      addAds.id_category_finalAddAds == 15 ||
                      addAds.id_category_finalAddAds == 16 ||
                      addAds.id_category_finalAddAds == 18 ||
                      addAds.id_category_finalAddAds == 19 ||
                      addAds.id_category_finalAddAds == 21) &&
                      (addAds.interfaceSelectedAddAds == null ||
                          addAds.interfaceSelectedAddAds == '0')) {
                    _onInterfaceCheck();
                  } else {
                    // addAds.setCurrentStageAddAds(6);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdsPriceScreen()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
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
                            .continuee,
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
    });
  }
}
