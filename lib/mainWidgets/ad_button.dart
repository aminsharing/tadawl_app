import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'custom_text_style.dart';

class AdButton extends StatelessWidget {
  const AdButton({
    Key key,
    @required this.onPressed,
    @required this.ads_image,
    @required this.title,
    @required this.idSpecial,
    @required this.price,
    @required this.space,
    @required this.ads_city,
    @required this.ads_neighborhood,
    @required this.video,
  }) : super(key: key);
  final Function onPressed;
  final String ads_image;
  final String title;
  final String idSpecial;
  final String price;
  final String space;
  final String ads_city;
  final String ads_neighborhood;
  final String video;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: mediaQuery.size.width,
        height: 150.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff8d8d8d),
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 0.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              Container(
                width: 180.0,
                height: 150.0,
                child: CachedNetworkImage(
                  placeholder: (_, url) => Center(
                      child: CircularProgressIndicator()),
                  errorWidget: (__ ,_, error) => Icon(Icons.error),
                  imageUrl: 'https://tadawl-store.com/API/assets/images/ads/$ads_image',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Random().nextInt(50).toDouble(),
                    Random().nextInt(50).toDouble(),
                    5,
                    5),
                child: Opacity(
                  opacity: 0.7,
                  //opacity: 0.7,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/logo22.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(title,
                        style: CustomTextStyle(
                          fontSize: 20,
                          color: const Color(
                              0xff000000),
                        ).getTextStyle(),
                      ),
                      if (idSpecial == '1')
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Icon(
                            Icons.verified,
                            color:
                            Color(0xffe6e600),
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(
                              0xff00cccc),
                        ).getTextStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations.of(context).rial,
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(
                                0xff00cccc),
                          ).getTextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Text(
                        space,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(
                              0xff000000),
                        ).getTextStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets
                            .fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations.of(
                              context)
                              .m2,
                          style:
                          CustomTextStyle(

                            fontSize: 15,
                            color: const Color(
                                0xff000000),
                          ).getTextStyle(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                        5, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        if (ads_city != null || ads_neighborhood != null)
                          Text(
                            '$ads_city - $ads_neighborhood',
                            style: CustomTextStyle(
                              fontSize: 10,
                              color: const Color(
                                  0xff000000),
                            ).getTextStyle(),
                          ),
                        if (video.isNotEmpty)
                          Padding(
                            padding:
                            const EdgeInsets
                                .fromLTRB(
                                0, 0, 5, 0),
                            child: Icon(
                              Icons.videocam_outlined,
                              color:
                              Color(0xff00cccc),
                              size: 30,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}