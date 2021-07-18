import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';

class UpdateDetails extends StatelessWidget {
  UpdateDetails({
    Key key,
  }) : super(key: key);




  final GlobalKey<FormState> _updateAdsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, child) {

      print("UpdateDetails -> UpdateDetailsProvider");


      var mediaQuery = MediaQuery.of(context);
      // ignore: omit_local_variable_types
      Map data = {};
      data = ModalRoute.of(context).settings.arguments;
      var _id_description = data['id_description'];
      var provider = Provider.of<LocaleProvider>(context, listen: false);
      var _lang = provider.locale.toString();
      updateDetails.getCategoryeInfoUpdate(context);
      Provider.of<AdPageProvider>(context, listen: false).getAdsPageInfoUpdateDetails(context, _id_description);

      if(!updateDetails.typeAqarUpdate.contains(true)){
        // updateDetails.adsPage.first
        updateDetails.setTyprAqarUpdate(int.parse(Provider.of<MutualProvider>(context, listen: false).adsPage.first.idTypeAqar), false);
      }
      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Form(
            key: _updateAdsKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (updateDetails.currentStageUpdateDetails == null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: mediaQuery.size.width,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff00cccc),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 30, 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Color(0xffffffff),
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            Provider.of<MutualProvider>(context, listen: false)
                                            .getAllAdsPageInfo(context, _id_description);

                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdPage()),
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .chooseCategory,
                                        style: CustomTextStyle(

                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (updateDetails.categoryUpdate.isNotEmpty)
                        if (Provider.of<AdPageProvider>(context, listen: false).adsUpdateDetails.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                for (int i = 1;
                                    i < updateDetails.categoryUpdate.length;
                                    i++)
                                  if (Provider.of<AdPageProvider>(context, listen: false)
                                          .adsUpdateDetails.first.idCategory ==
                                      updateDetails
                                          .categoryUpdate[i].id_category)
                                    TextButton(
                                      onPressed: () {
                                        updateDetails.updateCategoryDetails(
                                            int.parse(updateDetails
                                                .categoryUpdate[i].id_category),
                                            updateDetails
                                                .categoryUpdate[i].name);
                                        updateDetails
                                            .setCurrentStageUpdateDetails(1);
                                      },
                                      child: Container(
                                        width: mediaQuery.size.width,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xff00cccc),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _lang != 'en_US'
                                                    ? updateDetails
                                                        .categoryUpdate[i].name
                                                    : updateDetails
                                                        .categoryUpdate[i]
                                                        .en_name,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xffffffff),
                                                ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xffffffff),
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    TextButton(
                                      onPressed: () {
                                        updateDetails.updateCategoryDetails(
                                            int.parse(updateDetails
                                                .categoryUpdate[i].id_category),
                                            updateDetails
                                                .categoryUpdate[i].name);
                                        updateDetails
                                            .setCurrentStageUpdateDetails(1);
                                      },
                                      child: Container(
                                        width: mediaQuery.size.width,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _lang != 'en_US'
                                                    ? updateDetails
                                                        .categoryUpdate[i].name
                                                    : updateDetails
                                                        .categoryUpdate[i]
                                                        .en_name,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff00cccc),
                                                ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xff00cccc),
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          )
                        else
                          Container(),
                    ],
                  ),
                //...........end 1 screen.............
                if (updateDetails.currentStageUpdateDetails == 1)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: mediaQuery.size.width,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff00cccc),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 30, 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Color(0xffffffff),
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            updateDetails
                                                .setCurrentStageUpdateDetails(
                                                    null);
                                          },
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .updateDetails,
                                        style: CustomTextStyle(

                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
//...............................
                      if (updateDetails.id_category_finalUpdate == 1 ||
                          updateDetails.id_category_finalUpdate == 2 ||
                          updateDetails.id_category_finalUpdate == 3 ||
                          updateDetails.id_category_finalUpdate == 4 ||
                          updateDetails.id_category_finalUpdate == 5 ||
                          updateDetails.id_category_finalUpdate == 6 ||
                          updateDetails.id_category_finalUpdate == 7 ||
                          updateDetails.id_category_finalUpdate == 8 ||
                          updateDetails.id_category_finalUpdate == 9 ||
                          updateDetails.id_category_finalUpdate == 10 ||
                          updateDetails.id_category_finalUpdate == 11 ||
                          updateDetails.id_category_finalUpdate == 12 ||
                          updateDetails.id_category_finalUpdate == 13 ||
                          updateDetails.id_category_finalUpdate == 14 ||
                          updateDetails.id_category_finalUpdate == 15 ||
                          updateDetails.id_category_finalUpdate == 16 ||
                          updateDetails.id_category_finalUpdate == 17 ||
                          updateDetails.id_category_finalUpdate == 18 ||
                          updateDetails.id_category_finalUpdate == 19 ||
                          updateDetails.id_category_finalUpdate == 20 ||
                          updateDetails.id_category_finalUpdate == 21)
                        Column(
                          children: [
                            if (updateDetails.id_category_finalUpdate == 2 ||
                                updateDetails.id_category_finalUpdate == 19 ||
                                updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 18 ||
                                updateDetails.id_category_finalUpdate == 10 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 7 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 21)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).interface,
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
                                              AppLocalizations.of(context)
                                                  .interface,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color: const Color(0xff989696),
                                              ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                            ),
                                            value: updateDetails.interfaceSelectedUpdate ?? (int.parse(Provider.of<MutualProvider>(context, listen: false).adsPage.first.idInterface)-1).toString() ?? '1',
                                            onChanged: (String newValue) {
                                              updateDetails
                                                  .setInterfaceSelectedUpdate(
                                                      newValue);
                                            },
                                            items: _lang != 'en_US'
                                                ? Provider.of<MainPageProvider>(context, listen: false).Interface.map(
                                                    (Map map) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: map['id_type']
                                                          .toString(),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            //margin: EdgeInsets.only(left: 10),
                                                            //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                            child: Text(
                                                              map['type'],
                                                              style: CustomTextStyle(
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
                                                : Provider.of<MainPageProvider>(context, listen: false).EnInterface
                                                    .map((Map map) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: map['id_type']
                                                          .toString(),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Text(
                                                              map['type'],
                                                              style: CustomTextStyle(
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
                            if (updateDetails.id_category_finalUpdate == 2 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 10 ||
                                updateDetails.id_category_finalUpdate == 11)
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
                                              10, 0, 10, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .commHousing,
                                            style: CustomTextStyle(

                                              fontSize: 10,
                                            ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .commercial,
                                            style: CustomTextStyle(

                                              fontSize: 10,
                                            ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .housing,
                                            style: CustomTextStyle(

                                              fontSize: 10,
                                            ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        updateDetails.setTyprAqarUpdate(index, true);
                                      },
                                      isSelected: updateDetails.typeAqarUpdate,
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
                            if (updateDetails.id_category_finalUpdate == 14)
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
                                            AppLocalizations.of(context).single,
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
                                            AppLocalizations.of(context).family,
                                            style: CustomTextStyle(

                                              fontSize: 13,
                                            ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        updateDetails.setFamilyUpdate(index);
                                      },
                                      isSelected: updateDetails.familyUpdate,
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
                            if (updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 20 ||
                                updateDetails.id_category_finalUpdate == 17)
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
                                            AppLocalizations.of(context).daily,
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
                                            AppLocalizations.of(context)
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
                                            AppLocalizations.of(context).annual,
                                            style: CustomTextStyle(

                                              fontSize: 13,
                                            ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        updateDetails.setPlanUpdate(index);
                                      },
                                      isSelected: updateDetails.planUpdate,
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
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).lounges,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.LoungesUpdateUpdate == 5)
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
                                        updateDetails.LoungesUpdateUpdate
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
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.LoungesUpdateUpdate,
                                min: 0,
                                max: 5,
                                divisions: 5,
                                label: updateDetails.LoungesUpdateUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setLoungesUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).toilets,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.ToiletsUpdateUpdate == 5)
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
                                        updateDetails.ToiletsUpdateUpdate.floor().toString(),
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.ToiletsUpdateUpdate,
                                min: 0,
                                max: 5,
                                divisions: 5,
                                label: updateDetails.ToiletsUpdateUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setToiletsUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 2 ||
                                updateDetails.id_category_finalUpdate == 19 ||
                                updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 18 ||
                                updateDetails.id_category_finalUpdate == 10 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 7 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 21)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).streetWidth,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      updateDetails.StreetWidthUpdate == 0.0
                                        ?
                                      Provider.of<MutualProvider>(context, listen: false).adsQF[0].quantity
                                        :
                                      updateDetails.StreetWidthUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 2 ||
                                updateDetails.id_category_finalUpdate == 19 ||
                                updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 18 ||
                                updateDetails.id_category_finalUpdate == 10 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 7 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 21)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: (updateDetails.StreetWidthUpdate == 0.0
                                    ?
                                double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[0].quantity)
                                    :
                                updateDetails.StreetWidthUpdate),
                                min: 0,
                                max: 99,
                                divisions: 99,
                                label: updateDetails.StreetWidthUpdate == 0.0
                                    ?
                                Provider.of<MutualProvider>(context, listen: false).adsQF[0].quantity
                                    :
                                updateDetails.StreetWidthUpdate.floor().toString(),
                                onChanged: (double value) {
                                  updateDetails.setStreetWidthUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).rooms,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.RoomsUpdate == 5)
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
                                        updateDetails.RoomsUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.RoomsUpdate,
                                min: 0,
                                max: 5,
                                divisions: 5,
                                label: updateDetails.RoomsUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setRoomsUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 11)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).apartments,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.ApartmentsUpdate == 30)
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
                                        (updateDetails.ApartmentsUpdate == 0.0
                                            ?
                                        double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[5].quantity)
                                            :
                                        updateDetails.ApartmentsUpdate).floor()
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
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 11)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.ApartmentsUpdate == 0.0
                                    ?
                                double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[5].quantity)
                                    :
                                updateDetails.ApartmentsUpdate,
                                min: 0,
                                max: 30,
                                divisions: 30,
                                label: (
                                    updateDetails.ApartmentsUpdate == 0.0
                                        ?
                                    double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[5].quantity)
                                        :
                                    updateDetails.ApartmentsUpdate
                                ).floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setApartementsUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).floor,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.FloorUpdate == 0)
                                      Text(
                                        AppLocalizations.of(context).undefined,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else if (updateDetails.FloorUpdate == 1)
                                      Text(
                                        AppLocalizations.of(context)
                                            .groundFloor,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else if (updateDetails.FloorUpdate == 2)
                                      Text(
                                        AppLocalizations.of(context).first,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else if (updateDetails.FloorUpdate == 20)
                                      Text(
                                        '+20',
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else
                                      Text(
                                        updateDetails.FloorUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.FloorUpdate,
                                min: 0,
                                max: 20,
                                divisions: 20,
                                label: updateDetails.FloorUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setFloorUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 19 ||
                                updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 18 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 7 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 17 ||
                                updateDetails.id_category_finalUpdate == 21)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .ageOfRealEstate,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (updateDetails.AgeOfRealEstateUpdate == -1)
                                      Text(
                                        AppLocalizations.of(context).undefined,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else if (updateDetails.AgeOfRealEstateUpdate == 0 && double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[6].quantity) == 0)
                                      Text(
                                        AppLocalizations.of(context).lessYear,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff000000),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      )
                                    else if (updateDetails
                                            .AgeOfRealEstateUpdate ==
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
                                      updateDetails.AgeOfRealEstateUpdate == 0.0
                                      ?
                                      Provider.of<MutualProvider>(context, listen: false).adsQF[6].quantity
                                      :
                                      updateDetails.AgeOfRealEstateUpdate
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
                            if (updateDetails.id_category_finalUpdate == 19 ||
                                updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 18 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 7 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 17 ||
                                updateDetails.id_category_finalUpdate == 21)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.AgeOfRealEstateUpdate == 0.0
                                    ?
                                double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[6].quantity)
                                    :
                                updateDetails.AgeOfRealEstateUpdate,
                                min: 0,
                                max: 36,
                                divisions: 36,
                                label:
                                updateDetails.StoresUpdate == 0.0
                                    ?
                                Provider.of<MutualProvider>(context, listen: false).adsQF[4].quantity
                                    :
                                updateDetails.StoresUpdate.floor()
                                        .toString(),
                                onChanged: (double value) {
                                  updateDetails.setAgeOfREUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 6 ||
                                updateDetails.id_category_finalUpdate == 14)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).stores,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      updateDetails.AgeOfRealEstateUpdate == 0.0
                                          ?
                                      Provider.of<MutualProvider>(context, listen: false).adsQF[6].quantity
                                          :
                                      updateDetails.AgeOfRealEstateUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 11)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.StoresUpdate == 0.0
                                    ?
                                double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[4].quantity)
                                    :
                                updateDetails.StoresUpdate,
                                min: 0,
                                max: 50,
                                divisions: 50,
                                label: updateDetails.StoresUpdate == 0.0
                                    ?
                                Provider.of<MutualProvider>(context, listen: false).adsQF[4].quantity
                                    :
                                updateDetails.StoresUpdate.floor().toString(),
                                onChanged: (double value) {
                                  updateDetails.setStoresUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 11)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).rooms,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      updateDetails.RoomsUpdate == 0.0
                                          ?
                                      Provider.of<MutualProvider>(context, listen: false).adsQF[7].quantity
                                          :
                                      updateDetails.RoomsUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 11)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.RoomsUpdate == 0.0
                                    ?
                                double.parse(Provider.of<MutualProvider>(context, listen: false).adsQF[7].quantity)
                                    :
                                updateDetails.RoomsUpdate,
                                min: 0,
                                max: 9999,
                                divisions: 9999,
                                label: updateDetails.RoomsUpdate == 0.0
                                    ?
                                Provider.of<MutualProvider>(context, listen: false).adsQF[7].quantity
                                    :
                                updateDetails.RoomsUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setRoomsUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 13 ||
                                updateDetails.id_category_finalUpdate == 6)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).trees,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      updateDetails.TreesUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 13 ||
                                updateDetails.id_category_finalUpdate == 6)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.TreesUpdate,
                                min: 0,
                                max: 9999,
                                divisions: 9999,
                                label: updateDetails.TreesUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setTreesUpdate(value);
                                },
                              ),
                            if (updateDetails.id_category_finalUpdate == 13 ||
                                updateDetails.id_category_finalUpdate == 6)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).wells,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff000000),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      updateDetails.WellsUpdate.floor()
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
                            if (updateDetails.id_category_finalUpdate == 13 ||
                                updateDetails.id_category_finalUpdate == 6)
                              Slider(
                                activeColor: const Color(0xff00cccc),
                                value: updateDetails.WellsUpdate,
                                min: 0,
                                max: 10,
                                divisions: 10,
                                label: updateDetails.WellsUpdate.floor()
                                    .toString(),
                                onChanged: (double value) {
                                  updateDetails.setWellsUpdate(value);
                                },
                              ),
//........end sliders...........
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
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
                                      value:
                                          updateDetails.isHallStaircaseUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsHallStaircaseUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).driverRoom,
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
                                      value: updateDetails.isDriverRoomUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsDriverRoomUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).maidRoom,
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
                                      value: updateDetails.isMaidRoomUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsMaidRoomUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).swimmingPool,
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
                                      value: updateDetails.isSwimmingPoolUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsSwimmingPoolUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
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
                                      value:
                                          updateDetails.isFootballCourtUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsFootballCourtUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
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
                                      value:
                                          updateDetails.isVolleyballCourtUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsVolleyballCourtUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 16 ||
                                updateDetails.id_category_finalUpdate == 3 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 11 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 17)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).furnished,
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
                                      value: updateDetails.isFurnishedUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsFurnishedUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 6)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).verse,
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
                                      value: updateDetails.isVerseUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsVerseUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).yard,
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
                                      value: updateDetails.isMonstersUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsMonstersUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4 ||
                                updateDetails.id_category_finalUpdate == 17)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).kitchen,
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
                                      value: updateDetails.isKitchenUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsKitchenUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).appendix,
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
                                      value: updateDetails.isAppendixUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsAppendixUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 9 ||
                                updateDetails.id_category_finalUpdate == 4)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).carEntrance,
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
                                      value: updateDetails.isCarEntranceUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsCarEntranceUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).cellar,
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
                                      value: updateDetails.isCellarUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsCellarUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 8 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).elevator,
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
                                      value: updateDetails.isElevatorUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsElevatorUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 1 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).duplex,
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
                                      value: updateDetails.isDuplexUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails.setIsDuplexUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 15 ||
                                updateDetails.id_category_finalUpdate == 14 ||
                                updateDetails.id_category_finalUpdate == 9)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).conditioner,
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
                                      value: updateDetails.isConditionerUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsConditionerUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
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
                                      value:
                                          updateDetails.isAmusementParkUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsAmusementParkUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (updateDetails.id_category_finalUpdate == 12 ||
                                updateDetails.id_category_finalUpdate == 5 ||
                                updateDetails.id_category_finalUpdate == 20)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
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
                                      value:
                                          updateDetails.isFamilyPartitionUpdate,
                                      borderRadius: 15.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        updateDetails
                                            .setIsFamilyPartitionUpdate(val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
//........end switches...........
//...............................
                      TextButton(
                        onPressed: () {
                          if (!_updateAdsKey.currentState.validate()) {
                            return;
                          }
                          _updateAdsKey.currentState.save();
                          updateDetails.setCurrentStageUpdateDetails(2);
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
                                AppLocalizations.of(context).continuee,
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
                //...........end 2 screen.............
                if (updateDetails.currentStageUpdateDetails == 2)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: mediaQuery.size.width,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff00cccc),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 30, 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Color(0xffffffff),
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            updateDetails
                                                .setCurrentStageUpdateDetails(
                                                    1);
                                          },
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .updateDetails,
                                        style: CustomTextStyle(

                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                        ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (updateDetails.id_category_finalUpdate != 14)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).space,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                width: mediaQuery.size.width * 0.6,
                                height: 50,
                                child: TextFormField(
                                  controller:
                                  Provider.of<AdPageProvider>(context, listen: false).spaceControllerUpdate ??
                                          TextEditingController(text: ''),
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context).space,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff989696),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.number,
                                  minLines: 1,
                                  maxLines: 1,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .reqSpace;
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    Provider.of<AdPageProvider>(context, listen: false)
                                        .setOnChangedSpaceUpdate(value);
                                  },
                                  onSaved: (String value) {
                                    Provider.of<AdPageProvider>(context, listen: false).setOnSavedSpaceUpdate(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (updateDetails.id_category_finalUpdate == 2)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).meterPrice,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                width: mediaQuery.size.width * 0.6,
                                height: 50,
                                child: TextFormField(
                                  controller: Provider.of<AdPageProvider>(context, listen: false)
                                          .meterPriceControllerUpdate ??
                                      TextEditingController(text: ''),
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context).meterPrice,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff989696),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.number,
                                  minLines: 1,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    Provider.of<AdPageProvider>(context, listen: false)
                                        .setOnChangedMeterPriceUpdate(value);
                                  },
                                  onSaved: (value) {
                                    Provider.of<AdPageProvider>(context, listen: false)
                                        .setOnSavedMeterPriceUpdate(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).totalPrice,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(
                              width: mediaQuery.size.width * 0.6,
                              height: 50,
                              child: TextFormField(
                                controller:
                                Provider.of<AdPageProvider>(context, listen: false).priceControllerUpdate ??
                                        TextEditingController(text: ''),
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).totalPrice,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                keyboardType: TextInputType.number,
                                minLines: 1,
                                maxLines: 1,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .reqTotalPrice;
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  Provider.of<AdPageProvider>(context, listen: false)
                                      .setOnSavedTotalPriceUpdate(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).aqarDesc,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: Provider.of<AdPageProvider>(context, listen: false).descControllerUpdate ??
                              TextEditingController(text: ''),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .writeAdditionalDetailsHere,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          maxLines: 4,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).reDesc;
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            Provider.of<AdPageProvider>(context, listen: false).setOnSavedDetailsUpdate(value);
                          },
                        ),
                      ),

                      //.....................................................................
                      CheckboxListTile(
                        activeColor: const Color(0xff00cccc),
                        title: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdvertisingFee()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context).advFees,
                                style: CustomTextStyle(

                                  fontSize: 10,
                                  color: Colors.blue,
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).committed,
                              style: CustomTextStyle(

                                fontSize: 10,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context).usageTerms,
                                style: CustomTextStyle(

                                  fontSize: 10,
                                  color: Colors.blue,
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).accept,
                              style: CustomTextStyle(

                                fontSize: 10,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        value: updateDetails.AcceptedUpdate,
                        onChanged: (bool value) {
                          updateDetails.setAcceptedUpdate(value);
                        },
                      ),
                      if (updateDetails.AcceptedUpdate == true)
                        TextButton(
                          onPressed: () {
                            if (!_updateAdsKey.currentState.validate()) {
                              return;
                            }
                            _updateAdsKey.currentState.save();
                            updateDetails.updateDetails(
                                context,
                                _id_description,
                                Provider.of<AdPageProvider>(context, listen: false).detailsAqarUpdate,
                                updateDetails.isFootballCourtUpdate.toString(),
                                updateDetails.isVolleyballCourtUpdate
                                    .toString(),
                                updateDetails.isAmusementParkUpdate.toString(),
                                updateDetails.isFamilyPartitionUpdate
                                    .toString(),
                                updateDetails.isVerseUpdate.toString(),
                                updateDetails.isCellarUpdate.toString(),
                                updateDetails.isMonstersUpdate.toString(),
                                updateDetails.isMaidRoomUpdate.toString(),
                                updateDetails.isSwimmingPoolUpdate.toString(),
                                updateDetails.isDriverRoomUpdate.toString(),
                                updateDetails.isDuplexUpdate.toString(),
                                updateDetails.isHallStaircaseUpdate.toString(),
                                updateDetails.isConditionerUpdate.toString(),
                                updateDetails.isElevatorUpdate.toString(),
                                updateDetails.isCarEntranceUpdate.toString(),
                                updateDetails.isAppendixUpdate.toString(),
                                updateDetails.isKitchenUpdate.toString(),
                                updateDetails.isFurnishedUpdate.toString(),
                                updateDetails.StreetWidthUpdate.toString(),
                                updateDetails.FloorUpdate.toString(),
                                updateDetails.TreesUpdate.toString(),
                                updateDetails.WellsUpdate.toString(),
                                updateDetails.StoresUpdate.toString(),
                                updateDetails.ApartmentsUpdate.toString(),
                                updateDetails.AgeOfRealEstateUpdate.toString(),
                                updateDetails.RoomsUpdate.toString(),
                                updateDetails.ToiletsUpdateUpdate.toString(),
                                updateDetails.LoungesUpdateUpdate.toString(),
                                updateDetails.selectedTypeAqarUpdate.toString(),
                                updateDetails.selectedFamilyUpdate.toString(),
                                updateDetails.interfaceSelectedUpdate,
                                Provider.of<AdPageProvider>(context, listen: false).totalSpaceUpdate,
                                Provider.of<AdPageProvider>(context, listen: false).totalPricUpdatee,
                                updateDetails.selectedPlanUpdate.toString(),
                                updateDetails.id_category_finalUpdate
                                    .toString(),
                                null,
                                null);
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
                                  AppLocalizations.of(context).edit,
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
                      if (updateDetails.AcceptedUpdate == false)
                        TextButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg:
                                    'من فضلك وافق على شروط الاستخدام ورسوم الإعلان للمتابعة',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
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
                                    width: 1.0, color: const Color(0xff989696)),
                              ),
                              child: Center(
                                child: Text(
                                  'تعديل',
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                //...........end 3 screen.............
              ],
            ),
          ),
        ),
      );
    });
  }
}
