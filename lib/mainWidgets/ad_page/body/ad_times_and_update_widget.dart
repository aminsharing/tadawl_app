import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class AdTimesAndUpdateWidget extends StatelessWidget {
  AdTimesAndUpdateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();
    if (_lang != 'en_US') {
      Jiffy.locale('ar');
    } else if (_lang == 'en_US') {
      Jiffy.locale('en');
    }
    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      return Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          //         child: Text(
          //           AppLocalizations.of(context).advPosted,
          //           style: CustomTextStyle(
          //             fontSize: 15,
          //             color: const Color(0xff989696),
          //           ).getTextStyle(),
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //       Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          //           child: Text(
          //             Jiffy(DateTime.parse(adsPage.adsPage.timeAdded ?? '').add(Duration(hours: 3)))
          //                 .fromNow(),
          //          x   style: CustomTextStyle(
          //               fontSize: 15,
          //               color: const Color(0xff989696),
          //             ).getTextStyle(),
          //             textAlign: TextAlign.center,
          //           )),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.lastUpdate,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      Jiffy(DateTime.parse(adsPage.adsPage!.timeUpdated ?? '')
                              .add(Duration(hours: 3)))
                          .fromNow().replaceAll("بعد", "قبل").replaceAll("after", "before"),
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ],
      );
    });
  }
}
