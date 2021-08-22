import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    @required this.ads_road,
    @required this.video,
    this.timeUpdated,
    this.updateBtn = false,
    this.updateBtnPressed,
  }) : super(key: key);
  final Function onPressed;
  final String ads_image;
  final String title;
  final String idSpecial;
  final String price;
  final String space;
  final String ads_city;
  final String ads_neighborhood;
  final String ads_road;
  final String video;
  final String timeUpdated;
  final bool updateBtn;
  final Function updateBtnPressed;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.width*.34,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Stack(children: [
                Container(
                  width: mediaQuery.size.width*.34,
                  height: mediaQuery.size.width*.34,
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
            if(updateBtn)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    10, 5, 10, 5),
                child:
                DateTime.now().difference(DateTime.parse(timeUpdated)).inMinutes - 180 > 60
                    ?
                TextButton(
                  onPressed: updateBtnPressed,
                  child: Container(
                    width: mediaQuery.size.width *
                        0.15,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          5.0),
                      border: Border.all(
                          width: 1.0,
                          color: const Color(
                              0xff3f9d28)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(
                            context)
                            .updateAds,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: const Color(
                              0xff3f9d28),
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.center,
                      ),
                    ),
                  ),
                )
                    :
                TextButton(
                  onPressed: (){
                    Fluttertoast.showToast(
                        msg:
                        'ستتمكن من التحديث بعد ${60-(DateTime.now().difference(DateTime.parse(timeUpdated)).inMinutes - 180)} دقيقة',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 15.0);
                  },
                  child: Container(
                    width: mediaQuery.size.width *
                        0.15,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          5.0),
                      border: Border.all(
                          width: 1.0,
                          color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(
                            context)
                            .updateAds,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: Colors.grey,
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title??'',
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(
                          0xff000000),
                    ).getTextStyle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations.of(context).rial,
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(0xff00cccc),
                          ).getTextStyle(),
                        ),
                      ),
                      Text(
                        price,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations.of(context).m2,
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(0xff000000),
                          ).getTextStyle(),
                        ),
                      ),
                      Text(
                        space,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (ads_city != null)
                          Text(
                            '$ads_city ${ads_neighborhood != null ? '-' + ads_neighborhood : ''} ${ads_road != null ? '-' + ads_road : ''}',
                            style: CustomTextStyle(
                              fontSize: 10,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                          ),
                        if ((video??'').isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Icon(
                              Icons.videocam_outlined,
                              color: Color(0xff00cccc),
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