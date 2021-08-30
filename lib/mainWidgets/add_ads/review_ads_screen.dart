import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/general_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';
import 'package:tadawl_app/screens/general/terms_of_use.dart';

class ReviewAdsScreen extends StatelessWidget {
  const ReviewAdsScreen(this.addAdProvider,{Key key}) : super(key: key);
  final AddAdProvider addAdProvider;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
      return ChangeNotifierProvider<AddAdProvider>.value(
        value: addAdProvider,
        builder: (context, _){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xff1f2835),
              title: Center(
                widthFactor: 2.0,
                child: Text(
                  AppLocalizations
                      .of(context)
                      .adReview,
                  style: CustomTextStyle(
                    fontSize: 20,
                    color: const Color(0xffffffff),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              leadingWidth: 70.0,
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
              child: Consumer<AddAdProvider>(builder: (context, addAds, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (addAds.videoAddAds != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: SizedBox(
                          width: mediaQuery.size.width * 0.9,
                          height: 500,
                          child: AspectRatio(
                            aspectRatio: addAds
                                .videoControllerAddAds.value.aspectRatio,
                            child: Stack(
                              children: [
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: addAds
                                            .chewieControllerAddAds !=
                                            null &&
                                            addAds
                                                .chewieControllerAddAds
                                                .videoPlayerController
                                                .value
                                                .initialized
                                            ? Chewie(
                                          controller: addAds
                                              .chewieControllerAddAds,
                                        )
                                            : Container(),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      250, 5, 5, 5),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const CachedNetworkImageProvider(
                                            'https://tadawl-store.com/API/assets/images/logo22.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            addAds.category_finalAddAds.toString(),
                            style: CustomTextStyle(

                              fontSize: 20,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            addAds.totalPricAddAds,
                            style: CustomTextStyle(

                              fontSize: 20,
                              color: const Color(0xff04B404),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .rial,
                              style: CustomTextStyle(

                                fontSize: 20,
                                color: const Color(0xff04B404),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (addAds.selectedPlanAddAds == 1)
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                AppLocalizations
                                    .of(context)
                                    .annual,
                                style: CustomTextStyle(

                                  fontSize: 20,
                                  color: const Color(0xff04B404),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          if (addAds.selectedPlanAddAds == 2)
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                AppLocalizations
                                    .of(context)
                                    .monthly,
                                style: CustomTextStyle(

                                  fontSize: 20,
                                  color: const Color(0xff04B404),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          if (addAds.selectedPlanAddAds == 3)
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                AppLocalizations
                                    .of(context)
                                    .daily,
                                style: CustomTextStyle(

                                  fontSize: 20,
                                  color: const Color(0xff04B404),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                    addAds.imagesListAddAds.isNotEmpty
                        ?
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      child: Stack(
                        children: [
                          Container(
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.4,
                              child: PageView.builder(
                                itemCount:
                                addAds.imagesListAddAds.length,
                                itemBuilder: (context, position) {
                                  return Stack(
                                    children: [
                                      PinchZoomImage(
                                        image: Image.file(
                                          addAds.imagesListAddAds[
                                          position] ??
                                              '',
                                          width:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          height:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.4,
                                          fit: BoxFit.cover,
                                        ),
                                        zoomedBackgroundColor:
                                        Color.fromRGBO(
                                            240, 240, 240, 1.0),
                                        hideStatusBarWhileZooming:
                                        true,
                                        onZoomStart: () {},
                                        onZoomEnd: () {},
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            Random().nextInt(50).toDouble(),
                                            Random().nextInt(50).toDouble(),
                                            5,
                                            5),
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: const CachedNetworkImageProvider(
                                                    'https://tadawl-store.com/API/assets/images/logo22.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                onPageChanged: (index) {
                                  addAds
                                      .setCurrentControllerPageAddAds(
                                      index);
                                  // Provider.of<MutualProvider>(context, listen: false).randomPosition(200);
                                },
                                controller: addAds.controllerAddAds,
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 19,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (context, indexListView) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.all(4),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(30),
                                              color: addAds
                                                  .currentControllerPageAddAds ==
                                                  indexListView
                                                  ? Color(0xff04B404)
                                                  : Colors.grey),
                                        ),
                                      );
                                    },
                                    itemCount: addAds
                                        .imagesListAddAds.length,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                        :
                    Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Table(
                        border: TableBorder.all(
                            color: Color(0xffffffff), width: 2),
                        defaultVerticalAlignment:
                        TableCellVerticalAlignment.middle,
                        defaultColumnWidth: FractionColumnWidth(0.5),
                        children: [
                          if (addAds.totalSpaceAddAds != null)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .space,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        addAds.totalSpaceAddAds,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 5),
                                        child: Text(
                                          AppLocalizations
                                              .of(context)
                                              .m2,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.interfaceSelectedAddAds != null)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .interface,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.interfaceSelectedAddAds,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.selectedFamilyAddAds == 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .category,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .single,
                                    style: CustomTextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.selectedFamilyAddAds == 1)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .category,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .family,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.selectedTypeAqarAddAds == 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .aqarType,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .commHousing,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.selectedTypeAqarAddAds == 1)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .aqarType,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .commercial,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.selectedTypeAqarAddAds == 2)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .aqarType,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .housing,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.LoungesAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .lounges,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.LoungesAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.ToiletsAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .toilets,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.ToiletsAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.RoomsAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .rooms,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.RoomsAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.AgeOfRealEstateAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .ageOfRealEstate,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (addAds.AgeOfRealEstateAddAds <= 1)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 5, 5, 5),
                                    child: Text(
                                      AppLocalizations
                                          .of(context)
                                          .neww,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 5, 5, 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              0, 5, 5, 5),
                                          child: Text(
                                            AppLocalizations
                                                .of(context)
                                                .year,
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color:
                                              const Color(0xff989696),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          addAds.AgeOfRealEstateAddAds
                                              .floor()
                                              .toString(),
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          if (addAds.ApartmentsAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .apartments,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.ApartmentsAddAds.floor()
                                        .toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.StoresAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .stores,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.StoresAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.WellsAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .wells,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.WellsAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.TreesAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .trees,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    addAds.TreesAddAds.floor().toString(),
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.FloorAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .floor,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (addAds.FloorAddAds == 1)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 5, 5, 5),
                                    child: Text(
                                      AppLocalizations
                                          .of(context)
                                          .groundFloor,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                else
                                  if (addAds.FloorAddAds == 2)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 5),
                                      child: Text(
                                        AppLocalizations
                                            .of(context)
                                            .first,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 5),
                                      child: Text(
                                        addAds.FloorAddAds.floor()
                                            .toString(),
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                              ],
                            ),
                          if (addAds.StreetWidthAddAds != 0)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .streetWidth,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        addAds.StreetWidthAddAds.floor()
                                            .toString(),
                                        style: CustomTextStyle(

                                          fontSize: 13,
                                          color: const Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 5),
                                        child: Text(
                                          AppLocalizations
                                              .of(context)
                                              .m,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isFurnishedAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .furnished,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isKitchenAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .kitchen,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isAppendixAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .appendix,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isCarEntranceAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .carEntrance,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isElevatorAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .elevator,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isConditionerAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .conditioner,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isHallStaircaseAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .hallStaircase,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isDuplexAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .duplex,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isDriverRoomAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .driverRoom,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isSwimmingPoolAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .swimmingPool,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isMaidRoomAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .maidRoom,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isYardAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .yard,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isVerseAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .verse,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isCellarAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .cellar,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isFamilyPartitionAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .familyPartition,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isAmusementParkAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .amusementPark,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isVolleyballCourtAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .volleyballCourt,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          if (addAds.isFootballCourtAddAds == true)
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations
                                        .of(context)
                                        .footballCourt,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff04B404),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations
                                .of(context)
                                .desc,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              addAds.detailsAqarAddAds,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      activeColor: const Color(0xff04B404),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations
                                .of(context)
                                .accept,
                            style: CustomTextStyle(

                              fontSize: 13,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                            textAlign: TextAlign.right,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<GeneralProvider>(
                                        create: (_) => GeneralProvider(),
                                        child: TermsOfUse(),
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .usageTerms,
                              style: CustomTextStyle(

                                fontSize: 13,
                                color: Colors.blue,
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            AppLocalizations
                                .of(context)
                                .committed,
                            style: CustomTextStyle(

                              fontSize: 13,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                            textAlign: TextAlign.right,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdvertisingFee()),
                              );
                            },
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .advFees,
                              style: CustomTextStyle(

                                fontSize: 13,
                                color: Colors.blue,
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      value: addAds.AcceptedAddAds,
                      onChanged: (bool value) {
                        addAds.setAcceptedAddAds(value);
                      },
                    ),
                    if (addAds.AcceptedAddAds == true)
                      TextButton(
                        onPressed: () {
                          // addAds.setAcceptedAddAds(false);
                          if(!addAds.isSending) {
                            addAds.isSending = true;
                            addAds.addNewAd(
                            context,
                            addAds.detailsAqarAddAds,
                            addAds.isFootballCourtAddAds.toString(),
                            addAds.isVolleyballCourtAddAds.toString(),
                            addAds.isAmusementParkAddAds.toString(),
                            addAds.isFamilyPartitionAddAds.toString(),
                            addAds.isVerseAddAds.toString(),
                            addAds.isCellarAddAds.toString(),
                            addAds.isYardAddAds.toString(),
                            addAds.isMaidRoomAddAds.toString(),
                            addAds.isSwimmingPoolAddAds.toString(),
                            addAds.isDriverRoomAddAds.toString(),
                            addAds.isDuplexAddAds.toString(),
                            addAds.isHallStaircaseAddAds.toString(),
                            addAds.isConditionerAddAds.toString(),
                            addAds.isElevatorAddAds.toString(),
                            addAds.isCarEntranceAddAds.toString(),
                            addAds.isAppendixAddAds.toString(),
                            addAds.isKitchenAddAds.toString(),
                            addAds.isFurnishedAddAds.toString(),
                            addAds.StreetWidthAddAds.toString(),
                            addAds.FloorAddAds.toString(),
                            addAds.TreesAddAds.toString(),
                            addAds.WellsAddAds.toString(),
                            addAds.StoresAddAds.toString(),
                            addAds.ApartmentsAddAds.toString(),
                            addAds.AgeOfRealEstateAddAds.toString(),
                            addAds.RoomsAddAds.toString(),
                            addAds.ToiletsAddAds.toString(),
                            addAds.LoungesAddAds.toString(),
                            addAds.selectedTypeAqarAddAds.toString(),
                            addAds.selectedFamilyAddAds.toString(),
                            addAds.interfaceSelectedAddAds,
                            addAds.totalSpaceAddAds,
                            addAds.totalPricAddAds,
                            addAds.selectedPlanAddAds.toString(),
                            addAds.id_category_finalAddAds.toString(),
                            addAds.ads_cordinates_latAddAds.toString(),
                            addAds.ads_cordinates_lngAddAds.toString(),
                            null,
                            null,
                            locale.phone,
                            addAds.ads_cityAddAds,
                            addAds.ads_neighborhoodAddAds,
                            addAds.ads_roadAddAds,
                            addAds.videoAddAds,
                            addAds.imagesListAddAds,
                          );
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
                                  width: 1.0,
                                  color: const Color(0xff3f9d28)),
                            ),
                            child: Center(
                              child:
                              addAds.isSending
                                  ?
                              LinearProgressIndicator()
                                  :
                              Text(
                                AppLocalizations.of(context).postAdvertisement,
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
                    if (addAds.AcceptedAddAds == false)
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
                                  width: 1.0,
                                  color: const Color(0xff989696)),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations
                                    .of(context)
                                    .postAdvertisement,
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
                );
              }),
            ),
          );
        },
      );
  }
}
