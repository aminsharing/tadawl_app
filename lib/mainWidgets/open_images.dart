import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';

class OpenImages extends StatelessWidget {
  OpenImages({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
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
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          AppLocalizations.of(context).adsImages,
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff00cccc),
      ),
      body: Consumer<AdPageProvider>(builder: (context, images, child) {
        print("OpenImages -> AdPageProvider");
        return ListView.separated(
          itemCount: images.image.length,
          itemBuilder: (context, i){
          return Stack(children: [
            PinchZoomImage(
              image: CachedNetworkImage(
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: 'https://tadawl.com.sa/API/assets/images/ads/${images.image[i].ads_image}',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              zoomedBackgroundColor:
              Color.fromRGBO(240, 240, 240, 1.0),
              hideStatusBarWhileZooming: true,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Random().nextInt(50).toDouble(), Random().nextInt(50).toDouble(), 5, 5),
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
          ]);
        },
          separatorBuilder: (BuildContext context, int index) => Padding(padding: const EdgeInsets.all(10.0),),);
      }),
    );
  }
}
