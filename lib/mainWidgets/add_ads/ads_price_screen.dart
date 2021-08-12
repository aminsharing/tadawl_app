import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/review_ads_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';


class AdsPriceScreen extends StatelessWidget {
  AdsPriceScreen(this.addAdProvider,{Key key}) : super(key: key);
  final AddAdProvider addAdProvider;

  final GlobalKey<FormState> _addAdsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          child: Form(
            key: _addAdsKey,
            child: Consumer<AddAdProvider>(builder: (context, addAds, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (addAds.id_category_finalAddAds != 14)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations
                                .of(context)
                                .space,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                          ),
                        ],
                      ),
                    ),
                  if (addAds.id_category_finalAddAds != 14)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        controller: addAds.spaceControllerAddAds ??
                            TextEditingController(text: ''),
                        decoration: InputDecoration(
                          labelText: AppLocalizations
                              .of(context)
                              .space,
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
                            return AppLocalizations
                                .of(context)
                                .reqSpace;
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          addAds.setOnChangedSpaceAddAds(value);
                        },
                        onSaved: (String value) {
                          addAds.setOnSavedSpaceAddAds(value);
                        },
                      ),
                    ),
                  if (addAds.id_category_finalAddAds == 2)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations
                                .of(context)
                                .meterPrice,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.6,
                            height: 50,
                            child: TextFormField(
                              controller:
                              addAds.meterPriceControllerAddAds,
                              decoration: InputDecoration(
                                labelText: AppLocalizations
                                    .of(context)
                                    .meterPrice,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.0),
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
                                addAds
                                    .setOnChangedMeterPriceAddAds(value);
                              },
                              onSaved: (value) {
                                addAds.setOnSavedMeterPriceAddAds(value);
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
                          AppLocalizations
                              .of(context)
                              .totalPrice,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff000000),
                          ).getTextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: addAds.priceControllerAddAds ??
                          TextEditingController(text: ''),
                      decoration: InputDecoration(
                        labelText:
                        AppLocalizations
                            .of(context)
                            .totalPrice,
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
                          return AppLocalizations
                              .of(context)
                              .reqTotalPrice;
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        addAds.setOnSavedTotalPriceAddAds(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations
                              .of(context)
                              .aqarDesc,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff000000),
                          ).getTextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: addAds.descControllerAddAds ?? TextEditingController(text: ''),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).writeAdditionalDetailsHere,
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
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 15,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return AppLocalizations
                              .of(context)
                              .reqDesc;
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        addAds.setOnSavedDetailsAddAds(value);
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (!_addAdsKey.currentState.validate()) {
                        return;
                      }
                      _addAdsKey.currentState.save();
                      // addAds.setCurrentStageAddAds(7);
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ChangeNotifierProvider<AddAdProvider>.value(
                        value: addAdProvider,
                        child: ReviewAdsScreen(),
                      )
                          ));
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
              );
            }),
          ),
        ),
      );
  }
}
