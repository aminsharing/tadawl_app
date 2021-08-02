import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/aqar_vr_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/aqar_vr.dart';

class AdInfoWidget extends StatelessWidget {
  AdInfoWidget({Key key, this.adsPage, this.mutualProv}) : super(key: key);

  final AdPageProvider adsPage;
  final MutualProvider mutualProv;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  adsPage.stopVideoAdsPage();
                  Share.share('${mutualProv.qrData}');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${mutualProv.adsPage.first.ads_city??'غير محدد'} - ${mutualProv.adsPage.first.ads_neighborhood??'غير محدد'}',
                      style: CustomTextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      '${mutualProv.adsPage.first.ads_road??'غير محدد'}',
                      style: CustomTextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Icon(
                  Icons.share,
                  color: Colors.grey,
                  size: 40,
                ),
                onPressed: () {
                  adsPage.stopVideoAdsPage();
                  Share.share('${mutualProv.qrData}');
                },
              ),
            ],
          ),
        ),
        if (mutualProv.adsUser.isNotEmpty)
          if (mutualProv.adsUser.first.phone == _phone)
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
              child: Container(
                width: mediaQuery.size.width,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 1.0, color: const Color(0xffe6e600)),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).advUpgrade,
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xffe6e600),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          else
            Container(),
        if (mutualProv.adsVR.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
            child: Column(
              children: [
                if (mutualProv.adsVR.first.state_aqar == '1')
                  Container(
                    width: mediaQuery.size.width,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: const Color(0xff3f9d28),
                          width: 1),
                      color: const Color(0xff3f9d28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              0, 0, 15, 0),
                          child: Icon(
                            Icons.verified,
                            color: Color(0xffffffff),
                            size: 35,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).verAqar,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else if (mutualProv.adsVR.first.state_aqar == '0')
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      AppLocalizations.of(context).rule33,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          )
        else
          Container(),
        if (mutualProv.adsUser.isNotEmpty)
          if (mutualProv.adsUser.first.phone == _phone)
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
              child: TextButton(
                onPressed: () {
                  adsPage.stopVideoAdsPage();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ChangeNotifierProvider<AqarVRProvider>(
                        create: (_) => AqarVRProvider(),
                        child: AqarVR(),
                      )
                  ));
                  // Navigator.pushNamed(context, '/main/aqar_vr',
                  //     arguments: {
                  //       'id_description':
                  //       mutualProv.adsPage.first.idDescription,
                  //     });
                },
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 1.0,
                        color: const Color(0xff00cccc)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).reVR,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff00cccc),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          else
            Container()
        else
          Container(),
        if (mutualProv.adsUser.isNotEmpty)
          if (mutualProv.adsUser.first.phone == _phone)
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
              child: TextButton(
                onPressed: () {
                  adsPage.stopVideoAdsPage();
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        AppLocalizations.of(context).uniqueAdv,
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                      content: Text(
                        AppLocalizations.of(context).rule34,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              5, 0, 20, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ChangeNotifierProvider<AqarVRProvider>(
                                        create: (_) => AqarVRProvider(),
                                        child: AqarVR(),
                                      )
                                  ));
                              // Navigator.pushNamed(
                              //     context, '/main/aqar_vr',
                              //     arguments: {
                              //       'id_description': mutualProv
                              //           .adsPage
                              //           .first
                              //           .idDescription,
                              //     });
                            },
                            child: Text(
                              AppLocalizations.of(context).reVR,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20, 0, 5, 0),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pop(false),
                            child: Text(
                              AppLocalizations.of(context).undo,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 1.0,
                        color: const Color(0xff3f9d28)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).makeUnique,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff3f9d28),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          else
            Container()
        else
          Container(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Table(
            border: TableBorder.all(
                color: Color(0xffffffff), width: 2),
            defaultVerticalAlignment:
            TableCellVerticalAlignment.middle,
            defaultColumnWidth: FractionColumnWidth(0.5),
            children: [
              if (mutualProv.adsPage.isNotEmpty)
                if (mutualProv.adsPage.first.idTypeAqar != '0' &&
                    mutualProv.adsPage.first.idTypeAqar != '-1' &&
                    mutualProv.adsPage.first.idTypeAqar != 'null')
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                    ),
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          AppLocalizations.of(context).aqarType,
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
                            if (mutualProv
                                .adsPage.first.idTypeAqar ==
                                '1')
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    0, 5, 5, 5),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .commHousing,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color:
                                    const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (mutualProv.adsPage.first.idTypeAqar == '2')
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    0, 5, 5, 5),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .commercial,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color:
                                    const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (mutualProv.adsPage.first.idTypeAqar == '3')
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    0, 5, 5, 5),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .housing,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color:
                                    const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              if (mutualProv.adsPage.first.idInterface != '1' &&
                  mutualProv.adsPage.first.idInterface != 'null')
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Text(
                        AppLocalizations.of(context).interface,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: <Widget>[
                          if (mutualProv.adsPage.first.idInterface ==
                              '2')
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0, 5, 5, 5),
                              child: Text(
                                AppLocalizations.of(context)
                                    .north,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else if (mutualProv.adsPage.first.idInterface ==
                              '3')
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0, 5, 5, 5),
                              child: Text(
                                AppLocalizations.of(context).east,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else if (mutualProv.adsPage.first.idInterface ==
                                '4')
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 5, 5, 5),
                                child: Text(
                                  AppLocalizations.of(context).west,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            else if (mutualProv.adsPage.first.idInterface ==
                                  '5')
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 5, 5, 5),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .south,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              else if (mutualProv.adsPage
                                    .first.idInterface ==
                                    '6')
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 5, 5, 5),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .northeast,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                else if (mutualProv.adsPage
                                      .first.idInterface ==
                                      '7')
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 5, 5),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .southeast,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  else if (mutualProv.adsPage
                                        .first.idInterface ==
                                        '8')
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 5),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .southwest,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    else if (mutualProv.adsPage
                                          .first.idInterface ==
                                          '9')
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 5, 5),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .northwest,
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color: const Color(0xff989696),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      else if (mutualProv.adsPage
                                            .first.idInterface ==
                                            '10')
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 5, 5),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .threeRoads,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color: const Color(0xff989696),
                                              ).getTextStyle(),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        else if (mutualProv.adsPage
                                              .first.idInterface ==
                                              '11')
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 5, 5, 5),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .fourRoads,
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
              if (mutualProv.adsPage.first.space != 'null')
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                  ),
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        AppLocalizations.of(context).space,
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
                            mutualProv.adsPage.first.space ?? '',
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff989696),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 0, 5, 0),
                            child: Text(
                              AppLocalizations.of(context).m2,
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
            ],
          ),
// space ......................
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              if (mutualProv.adsQF.isNotEmpty)
                Table(
                  border: TableBorder.all(
                      color: Color(0xffffffff), width: 2),
                  defaultVerticalAlignment:
                  TableCellVerticalAlignment.middle,
                  defaultColumnWidth: FractionColumnWidth(0.5),
                  children: [
                    for (var i = 0; i < mutualProv.adsQF.length; i++)
                      if (mutualProv.adsQF[i].quantity != '0' &&
                          mutualProv.adsQF[i].id_QFAT == '13')
                        TableRow(
                          decoration: BoxDecoration(
                            color: i.isEven
                                ? Color(0xffffffff)
                                : Color(0xfff2f2f2),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 5, 5, 5),
                              child: Text(
                                _lang != 'en_US'
                                    ? mutualProv.adsQF[i].title ?? ''
                                    : mutualProv
                                    .adsQF[i].eng_title ??
                                    '',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 5, 5, 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mutualProv.adsQF[i].quantity,
                                    style: CustomTextStyle(

                                      fontSize: 13,
                                      color:
                                      const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .m,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color:
                                      const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else if (mutualProv.adsQF[i].quantity != '-1')
                        if (mutualProv.adsQF[i].quantity != '0' &&
                            mutualProv.adsQF[i].id_QFAT == '11')
                          TableRow(
                            decoration: BoxDecoration(
                              color: i.isEven
                                  ? Color(0xffffffff)
                                  : Color(0xfff2f2f2),
                            ),
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    5, 5, 5, 5),
                                child: Text(
                                  _lang != 'en_US'
                                      ? mutualProv.adsQF[i].title ??
                                      ''
                                      : mutualProv.adsQF[i]
                                      .eng_title ??
                                      '',
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color:
                                    const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    5, 5, 5, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      mutualProv.adsQF[i].quantity,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(
                                            0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .year,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(
                                            0xff989696),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else if (mutualProv.adsQF[i].quantity !=
                            '0' &&
                            mutualProv.adsQF[i].id_QFAT == '10')
                          TableRow(
                            decoration: BoxDecoration(
                              color: i.isEven
                                  ? Color(0xffffffff)
                                  : Color(0xfff2f2f2),
                            ),
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    5, 5, 5, 5),
                                child: Text(
                                  _lang != 'en_US'
                                      ? mutualProv.adsQF[i].title ??
                                      ''
                                      : mutualProv.adsQF[i]
                                      .eng_title ??
                                      '',
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color:
                                    const Color(0xff989696),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    5, 5, 5, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    if (mutualProv
                                        .adsQF[i].quantity ==
                                        '1')
                                      Text(
                                        AppLocalizations.of(
                                            context)
                                            .groundFloor,
                                        style:
                                        CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(
                                              0xff989696),
                                        ).getTextStyle(),
                                        textAlign:
                                        TextAlign.center,
                                      )
                                    else if (mutualProv
                                        .adsQF[i].quantity ==
                                        '2')
                                      Text(
                                        AppLocalizations.of(
                                            context)
                                            .first,
                                        style:
                                        CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(
                                              0xff989696),
                                        ).getTextStyle(),
                                        textAlign:
                                        TextAlign.center,
                                      )
                                    else
                                      Text(
                                        mutualProv.adsQF[i].quantity,
                                        style:
                                        CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(
                                              0xff989696),
                                        ).getTextStyle(),
                                        textAlign:
                                        TextAlign.center,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else if (mutualProv.adsQF[i].quantity != '0')
                            TableRow(
                              decoration: BoxDecoration(
                                color: i.isEven
                                    ? Color(0xffffffff)
                                    : Color(0xfff2f2f2),
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      5, 5, 5, 5),
                                  child: Text(
                                    _lang != 'en_US'
                                        ? mutualProv.adsQF[i].title ??
                                        ''
                                        : mutualProv.adsQF[i]
                                        .eng_title ??
                                        '',
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color:
                                      const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      5, 5, 5, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        mutualProv.adsQF[i].quantity,
                                        style: CustomTextStyle(

                                          fontSize: 15,
                                          color: const Color(
                                              0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                  ],
                )
// quatity features ads ...........................
              else
                Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              if (mutualProv.adsBF.isNotEmpty)
                Table(
                  border: TableBorder.all(
                      color: Color(0xffffffff), width: 2),
                  defaultVerticalAlignment:
                  TableCellVerticalAlignment.middle,
                  defaultColumnWidth: FractionColumnWidth(0.5),
                  children: [
                    for (var i = 0; i < mutualProv.adsBF.length; i++)
                      if (mutualProv.adsBF[i].state == 'true')
                        TableRow(
                          decoration: BoxDecoration(
                            color: i.isOdd
                                ? Color(0xffffffff)
                                : Color(0xfff2f2f2),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 5, 5, 5),
                              child: Text(
                                _lang != 'en_US'
                                    ? mutualProv.adsBF[i].title ?? ''
                                    : mutualProv
                                    .adsBF[i].eng_title ??
                                    '',
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 5, 0),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    5, 0, 5, 0),
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Color(0xff00cccc),
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
// boolean features ads ..............
                  ],
                )
              else
                Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Table(
                border: TableBorder.all(
                    color: Color(0xffffffff), width: 2),
                defaultVerticalAlignment:
                TableCellVerticalAlignment.middle,
                defaultColumnWidth: FractionColumnWidth(0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                    ),
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          AppLocalizations.of(context).views,
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
                              mutualProv.adsPage.first.views ?? '',
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
// views score ............................
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                    ),
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          AppLocalizations.of(context).advID,
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
                              mutualProv.adsPage.first.idDescription ?? '',
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
// ads number ........................
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
