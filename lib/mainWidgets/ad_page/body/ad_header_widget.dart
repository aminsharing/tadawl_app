import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/mutual_provider.dart';
import 'package:tadawl_app/provider/test/mutual_provider.dart';

class AdHeaderWidget extends StatelessWidget {
  AdHeaderWidget({Key key, this.adsPage, this.mutualProv}) : super(key: key);

  final AdsProvider adsPage;
  final MutualProvider mutualProv;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (mutualProv.adsPage.first.idSpecial == '1')
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  child: Icon(
                    Icons.verified,
                    color: Color(0xffe6e600),
                    size: 30,
                  ),
                ),
              Text(
                mutualProv.adsPage.first.title ?? '',
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
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                mutualProv.adsPage.first.price ?? '',
                style: CustomTextStyle(
                  fontSize: 20,
                  color: const Color(0xff00cccc),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  AppLocalizations.of(context).rial,
                  style: CustomTextStyle(

                    fontSize: 20,
                    color: const Color(0xff00cccc),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              if (mutualProv.adsPage.first.idTypeRes == '1')
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Text(
                    AppLocalizations.of(context).daily,
                    style: CustomTextStyle(

                      fontSize: 20,
                      color: const Color(0xff00cccc),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              if (mutualProv.adsPage.first.idTypeRes == '2')
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    AppLocalizations.of(context).monthly,
                    style: CustomTextStyle(

                      fontSize: 20,
                      color: const Color(0xff00cccc),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              if (mutualProv.adsPage.first.idTypeRes == '3')
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    AppLocalizations.of(context).annual,
                    style: CustomTextStyle(

                      fontSize: 20,
                      color: const Color(0xff00cccc),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
            ],
          ),
        ),
        if (mutualProv.adsPage.first.video.isNotEmpty)
          FutureBuilder(
              future: adsPage.initializeFutureVideoPlyerAdsPage,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding:
                    const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: SizedBox(
                      width: mediaQuery.size.width,
                      height: 400,
                      child: AspectRatio(
                        aspectRatio: adsPage
                            .videoControllerAdsPage
                            .value
                            .aspectRatio,
                        child: Stack(
                          children: [
                            Column(
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: adsPage.chewieControllerAdsPage !=
                                        null &&
                                        adsPage
                                            .chewieControllerAdsPage
                                            .videoPlayerController
                                            .value
                                            .initialized
                                        ? Chewie(
                                      controller: adsPage
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
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        if (mutualProv.adsPageImages.isNotEmpty)
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height * 0.3,
            child: Stack(
              children: [
                Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * 0.3,
                    child: PageView.builder(
                      itemCount: mutualProv.countAdsPageImages(),
                      itemBuilder: (context, position) {
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                adsPage.stopVideoAdsPage();
                                adsPage.getImagesAdsPageInfo(context, mutualProv.idDescription);
                                Navigator.pushNamed(
                                    context, '/main/open_images',
                                    arguments: {
                                      'id_description':
                                      mutualProv.idDescription,
                                    });
                              },
                              child: PinchZoomImage(
                                image: CachedNetworkImage(
                                  imageUrl: 'https://tadawl.com.sa/API/assets/images/ads/${mutualProv.adsPageImages[position].ads_image}',
                                  width: mediaQuery.size.width,
                                  height: mediaQuery.size.height *
                                      0.3,
                                  fit: BoxFit.cover,
                                ),
                                zoomedBackgroundColor:
                                Color.fromRGBO(
                                    240, 240, 240, 1.0),
                                hideStatusBarWhileZooming: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  mutualProv.randdLeft,
                                  mutualProv.randdTop,
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
                        adsPage.currentControllerPageAdsPageFunc(
                            index);
                        mutualProv.randomPosition(200);
                      },
                      controller: adsPage.controllerAdsPage,
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
                                    color:
                                    adsPage.currentControllerPageAdsPage ==
                                        indexListView
                                        ? Color(0xff00cccc)
                                        : Colors.grey),
                              ),
                            );
                          },
                          itemCount: mutualProv.countAdsPageImages(),
                        )),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}