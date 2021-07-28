import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';

class Stage2 extends StatelessWidget {
  Stage2(this._id_description, {Key key}) : super(key: key);
  final String _id_description;
  final GlobalKey<FormState> _updateAdsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00cccc),
        centerTitle: true,
        leadingWidth: 70,
        title: Text(
          AppLocalizations.of(context)
              .updateDetails,
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            // updateDetails
            //     .setCurrentStageUpdateDetails(
            //     1);
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _updateAdsKey,
        child: Consumer2<UpdateDetailsProvider, AdPageProvider>(builder: (context, updateDetails, adPage, _){
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                            adPage.spaceControllerUpdate ??
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
                              adPage
                                  .setOnChangedSpaceUpdate(value);
                            },
                            onSaved: (String value) {
                              adPage.setOnSavedSpaceUpdate(value);
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
                            controller: adPage.meterPriceControllerUpdate ??
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
                              adPage
                                  .setOnChangedMeterPriceUpdate(value);
                            },
                            onSaved: (value) {
                              adPage
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
                          adPage.priceControllerUpdate ??
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
                            adPage
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
                    controller: adPage.descControllerUpdate ??
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
                      adPage.setOnSavedDetailsUpdate(value);
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
                          adPage.detailsAqarUpdate,
                          updateDetails.isFootballCourtUpdate.toString(),
                          updateDetails.isVolleyballCourtUpdate.toString(),
                          updateDetails.isAmusementParkUpdate.toString(),
                          updateDetails.isFamilyPartitionUpdate.toString(),
                          updateDetails.isVerseUpdate.toString(),
                          updateDetails.isCellarUpdate.toString(),
                          updateDetails.isYardUpdate.toString(),
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
                          adPage.totalSpaceUpdate,
                          adPage.totalPricUpdatee,
                          updateDetails.selectedPlanUpdate.toString(),
                          updateDetails.id_category_finalUpdate.toString(),
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
          );
        }),
      ),
    );
  }
}
