import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/views_chart.dart';
import 'package:tadawl_app/models/views_series.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

List<ViewsSeriesModel> dataa = [
  ViewsSeriesModel(
      day: 'الأحد',
      views: 50,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc))),
  ViewsSeriesModel(
      day: 'الاثنين',
      views: 3000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc))),
  ViewsSeriesModel(
      day: 'الثلاثاء',
      views: 2000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc))),
  ViewsSeriesModel(
      day: 'الأربعاء',
      views: 2500,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc))),
  ViewsSeriesModel(
      day: 'الخميس',
      views: 10000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc))),
  ViewsSeriesModel(
      day: 'الجمعة',
      views: 2000,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff1f2835))),
  ViewsSeriesModel(
      day: 'السبت',
      views: 1500,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff1f2835))),
];


class AdStatisticsWidget extends StatelessWidget {
  AdStatisticsWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      if (adsPage.adsUser != null) {
        if (adsPage.adsUser!.phone == locale.phone) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.advertisingStats,
                      style: CustomTextStyle(
                        fontSize: 20,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 300,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.advertisingStats,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                              child: adsPage.adsViews.isNotEmpty
                                  ? ViewsChart(
                                data: adsPage.adsViews,
                              )
                                  : ViewsChart(
                                data: dataa,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        else{
          return Container();
        }
      }else{
        return Container();
      }
    });
  }
}
