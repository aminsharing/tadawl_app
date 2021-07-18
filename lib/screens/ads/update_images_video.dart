import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_img_vid_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpdateImgVed extends StatelessWidget {
  UpdateImgVed({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateImgVedProvider>(builder: (context, updateImgVed, child) {


      print("UpdateImgVed -> UpdateImgVedProvider");

      var mediaQuery = MediaQuery.of(context);
      // ignore: omit_local_variable_types
      Map data = {};
      data = ModalRoute.of(context).settings.arguments;
      var _id_description = data['id_description'];
      //updateImgVed.randomPosition(200);
      Provider.of<AdPageProvider>(context, listen: false).getImagesAdsPageInfo(context, _id_description);

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Provider.of<MutualProvider>(context, listen: false)
                .getAllAdsPageInfo(context, _id_description);
                updateImgVed.stopVideoAdsUpdate();

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdPage()),
                  );
                });
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context).updateImgVid,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (Provider.of<AdPageProvider>(context, listen: false).image.isNotEmpty)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        AppLocalizations.of(context).currentAdsGallery,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width,
                      height: mediaQuery.size.height * 0.3,
                      child: Stack(
                        children: [
                          Container(
                              width: mediaQuery.size.width,
                              height: mediaQuery.size.height * 0.3,
                              child: PageView.builder(
                                itemCount: Provider.of<AdPageProvider>(context, listen: false).image.length,
                                itemBuilder: (context, position) {
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/main/open_images',
                                              arguments: {
                                                'id_description': Provider.of<AdPageProvider>(context, listen: false)
                                                    .image[position]
                                                    .idDescription,
                                              });
                                        },
                                        child: PinchZoomImage(
                                          image: CachedNetworkImage(
                                            imageUrl: 'https://tadawl.com.sa/API/assets/images/ads/${Provider.of<AdPageProvider>(context, listen: false).image[position].ads_image}',
                                            width: mediaQuery.size.width,
                                            height:
                                                mediaQuery.size.height * 0.3,
                                            fit: BoxFit.cover,
                                          ),
                                          zoomedBackgroundColor: Color.fromRGBO(
                                              240, 240, 240, 1.0),
                                          hideStatusBarWhileZooming: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            Provider.of<MutualProvider>(context, listen: false).randdLeft,
                                            Provider.of<MutualProvider>(context, listen: false).randdTop,
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
                                                    'https://tadawl.com.sa/API/assets/images/logo22.png'),
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
                                  updateImgVed
                                      .currentControllerPageImgVedUpdateFunc(
                                          index);
                                  Provider.of<MutualProvider>(context, listen: false).randomPosition(200);
                                },
                                controller: updateImgVed.controllerImgVedUpdate,
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 19,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, indexListView) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: updateImgVed
                                                          .currentControllerPageImgVedUpdate ==
                                                      indexListView
                                                  ? Color(0xff00cccc)
                                                  : Colors.grey),
                                        ),
                                      );
                                    },
                                    itemCount: Provider.of<AdPageProvider>(context, listen: false).image.length,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              else
                Container(),
              updateImgVed.imagesListUpdate.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: PageView.builder(
                                itemCount: updateImgVed.imagesListUpdate.length,
                                itemBuilder: (context, position) {
                                  return Stack(
                                    children: [
                                      PinchZoomImage(
                                        image: Image.file(
                                          updateImgVed
                                                  .imagesListUpdate[position] ??
                                              '',
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          fit: BoxFit.cover,
                                        ),
                                        zoomedBackgroundColor:
                                            Color.fromRGBO(240, 240, 240, 1.0),
                                        hideStatusBarWhileZooming: true,
                                        onZoomStart: () {},
                                        onZoomEnd: () {},
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            Provider.of<MutualProvider>(context, listen: false).randdLeft,
                                            Provider.of<MutualProvider>(context, listen: false).randdTop,
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
                                                    'https://tadawl.com.sa/API/assets/images/logo22.png'),
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
                                  updateImgVed
                                      .currentControllerPageImgVedUpdateFunc(
                                          index);
                                  Provider.of<MutualProvider>(context, listen: false).randomPosition(200);
                                },
                                controller: updateImgVed.controllerImgVedUpdate,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (updateImgVed.imagesListUpdate.length < 10)
                                    InkWell(
                                      onTap: () {
                                        updateImgVed.getImagesUpdate();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.blueGrey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)
                                                    .addImages,
                                                style: CustomTextStyle(

                                                    fontSize: 10,
                                                    color: Colors.blueGrey).getTextStyle(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      updateImgVed.removeImageAt(updateImgVed
                                          .currentControllerPageImgVedUpdate);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                    itemBuilder: (context, indexListView) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: updateImgVed
                                                          .currentControllerPageImgVedUpdate ==
                                                      indexListView
                                                  ? Color(0xff00cccc)
                                                  : Colors.grey),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        updateImgVed.imagesListUpdate.length,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: Center(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Container(
                                width: mediaQuery.size.width * 0.6,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff00cccc)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context).uplaodImages,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff00cccc),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 0),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Color(0xff00cccc),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              updateImgVed.getImagesUpdate();
                            },
                          ),
                        ),
                      ),
                    ),
              if (updateImgVed.videoUpdate != null)
                SizedBox(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.4,
                  child: AspectRatio(
                    aspectRatio: updateImgVed.videoControllerUpdate.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(updateImgVed.videoControllerUpdate),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 200, 5, 5),
                          child: Column(
                            children: [
                              if (updateImgVed.videoControllerUpdate.value.isPlaying)
                                TextButton(
                                  onPressed: () {
                                    updateImgVed.pausePlayVideoUpdate();
                                  },
                                  child: Icon(Icons.pause,
                                      color: Color(0xff0099ff), size: 40),
                                )
                              else
                                TextButton(
                                  onPressed: () {
                                    updateImgVed.pausePlayVideoUpdate();
                                  },
                                  child: Icon(Icons.play_arrow,
                                      color: Color(0xff00cc00), size: 40),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextButton(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Color(0xffff0000),
                              size: 40,
                            ),
                            onPressed: () {
                              updateImgVed.deleteVideoUpdate();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(Provider.of<MutualProvider>(context, listen: false).randdLeft,
                              Provider.of<MutualProvider>(context, listen: false).randdTop, 5, 5),
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const CachedNetworkImageProvider(
                                      'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if(Provider.of<AdPageProvider>(context, listen: false).videoControllerAdsPage != null)
                SizedBox(
                  width: mediaQuery.size.width,
                  height: 400,
                  child: AspectRatio(
                    aspectRatio: Provider.of<AdPageProvider>(context, listen: false)
                        .videoControllerAdsPage
                        .value
                        .aspectRatio,
                    child: Stack(
                      children: [
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Provider.of<AdPageProvider>(context, listen: false).chewieControllerAdsPage !=
                                    null &&
                                    Provider.of<AdPageProvider>(context, listen: false)
                                        .chewieControllerAdsPage
                                        .videoPlayerController
                                        .value
                                        .initialized
                                    ? Chewie(
                                  controller: Provider.of<AdPageProvider>(context, listen: false)
                                      .chewieControllerAdsPage,
                                )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              5, 300, 300, 5),
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const CachedNetworkImageProvider(
                                      'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(),
              TextButton(
                onPressed: () {
                  updateImgVed.getVideoUpdate();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Container(
                    width: mediaQuery.size.width * 0.6,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff00cccc)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).addVed,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff00cccc),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Icon(
                            Icons.videocam_rounded,
                            color: Color(0xff00cccc),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (updateImgVed.imagesListUpdate.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'تعديل صور العقار مطلوبة',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 15.0);
                  } else {
                    updateImgVed.updateImgVed(
                        context,
                        _id_description,
                        updateImgVed.imagesListUpdate,
                        updateImgVed.videoUpdate);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).rule32,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff8d8d8d),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
