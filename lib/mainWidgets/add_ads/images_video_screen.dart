import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/location_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';


class ImagesVideoScreen extends StatelessWidget {
  const ImagesVideoScreen(this.addAdProvider,{Key? key}) : super(key: key);
  final AddAdProvider addAdProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: const Color(0xff1f2835),
        title: Center(
          widthFactor: 4.5,
          child: Text(
            AppLocalizations
                .of(context)!
                .images,
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
      body: ChangeNotifierProvider<AddAdProvider>.value(
        value: addAdProvider,
        builder: (context, _){
          return Consumer<AddAdProvider>(builder: (context, addAds, child) {
            Future<bool?>? _onVidPressed() {
              return showDialog<bool>(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text(
                        AppLocalizations
                            .of(context)!
                            .addVed,
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff04B404),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                      content: Text(
                        AppLocalizations
                            .of(context)!
                            .vidHint,
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
                            onTap: () {
                              addAds.getCameraVideo(context);
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              AppLocalizations
                                  .of(context)!
                                  .fromCamera,
                              style: CustomTextStyle(

                                fontSize: 13,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: GestureDetector(
                            onTap: () {
                              addAds.getGalleryVideo(context);
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              AppLocalizations
                                  .of(context)!
                                  .fromGallery,
                              style: CustomTextStyle(

                                fontSize: 13,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  addAds.imagesListAddAds.isNotEmpty
                      ?
                  Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * 0.4,
                    child: Stack(
                      children: [
                        Container(
                            width: mediaQuery.size.width,
                            height: mediaQuery.size.height * 0.4,
                            child: PageView.builder(
                              itemCount:
                              addAds.imagesListAddAds.length,
                              itemBuilder: (context, position) {
                                return Stack(
                                  children: [
                                    PinchZoomImage(
                                      image: Image.file(
                                        addAds.imagesListAddAds[position],
                                        width: mediaQuery.size.width,
                                        height: mediaQuery.size.height * 0.4,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                if (addAds.imagesListAddAds.length < 10)
                                  InkWell(
                                    onTap: () {
                                      addAds.getImagesAddAds(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                              Colors.blueGrey,
                                              width: 1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              6)),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color:
                                              Colors.blueGrey,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              AppLocalizations
                                                  .of(
                                                  context)!
                                                  .addImages,
                                              style: CustomTextStyle(
                                                  fontSize: 10,
                                                  color: Colors
                                                      .blueGrey).getTextStyle(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                InkWell(
                                  onTap: () {
                                    addAds.removeImageAddAds();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius:
                                        BorderRadius.circular(
                                            30)),
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            addAds.getImagesAddAds(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 15, 0, 15),
                            child: Container(
                              width: mediaQuery.size.width * 0.6,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5.0),
                                color: const Color(0xffffffff),
                                border: Border.all(
                                    width: 1.0,
                                    color: const Color(0xff1f2835)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations
                                        .of(context)!
                                        .uplaodImages,
                                    style: CustomTextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff1f2835),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                        15, 0, 0, 0),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Color(0xff04B404),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (addAds.videoAddAds != null)
                    SizedBox(
                      width: mediaQuery.size.width * 0.9,
                      height: 500,
                      child: AspectRatio(
                        aspectRatio: addAds.chewieControllerAddAds!
                            .videoPlayerController.value.aspectRatio,
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
                                            .chewieControllerAddAds!
                                            .videoPlayerController
                                            .value
                                            .isInitialized
                                        ? Chewie(
                                      controller: addAds
                                          .chewieControllerAddAds!,
                                    )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 20, 250, 5),
                              child: TextButton(
                                onPressed: () {
                                  addAds.removeVideoAddAds();
                                },
                                child: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Color(0xffff0000),
                                  size: 40,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                  addAds.videoAddAds != null
                      ?
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Container(
                      width: mediaQuery.size.width * 0.6,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0,
                            color: const Color(0xff818181)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations
                                .of(context)!
                                .addVed,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff818181),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                15, 0, 0, 0),
                            child: Icon(
                              Icons.videocam_rounded,
                              color: Color(0xff818181),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      :
                  TextButton(
                    onPressed: _onVidPressed,
                    child: Container(
                      width: mediaQuery.size.width * 0.6,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0,
                            color: const Color(0xff1f2835)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations
                                .of(context)!
                                .addVed,
                            style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff1f2835),
                                fontWeight: FontWeight.w400
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                15, 0, 0, 0),
                            child: Icon(
                              Icons.videocam_rounded,
                              color: Color(0xff04B404),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // if (!addAdsKey.currentState.validate()) {
                      //   return;
                      // }
                      // addAdsKey.currentState.save();
                      if (addAds.videoAddAds != null) {
                        addAds.stopVideoAddAds();
                      }
                      // addAds.setCurrentStageAddAds(4);
                      addAds.getLocPer().then((value) {

                        addAds.getLoc().then((value) {

                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                LocationScreen(addAdProvider),
                            ));
                      });
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
                              width: 1.0, color: const Color(0xff04B404)),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations
                                .of(context)!
                                .continuee,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff04B404),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            AppLocalizations
                                .of(context)!
                                .rule32,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff8d8d8d),
                            ).getTextStyle(),
                            textAlign: _lang != 'en_US'
                                ? TextAlign.right
                                : TextAlign.left,
                            textDirection: _lang != 'en_US'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
