import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class Estimate extends StatelessWidget {
  Estimate({
    Key key,
    @required this.myAccountProvider,
  }) : super(key: key);
  final MyAccountProvider myAccountProvider;


  @override
  Widget build(BuildContext context) {
    return Consumer<MyAccountProvider>(builder: (context, estimateUser, child) {


      // ignore: omit_local_variable_types
      //Map data = {};
      //var user_phone;
      var provider = Provider.of<LocaleProvider>(context, listen: false);
      var _lang = provider.locale.toString();
      //data = ModalRoute.of(context).settings.arguments;
      //var user_phone = data['phone'];
      //estimateUser.getEstimatesInfo(context, user_phone);
      //estimateUser.getSumEstimatesInfo(context, user_phone);

      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 100,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff989696),
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (estimateUser.estimates.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      estimateUser.sumEstimates != null
                          ? AppLocalizations.of(context).estimate +
                              ' ${(double.parse(estimateUser.sumEstimates.sum_estimates) / estimateUser.estimates.length).toDouble().toStringAsFixed(1)} '
                          : AppLocalizations.of(context).estimate,
                      style: CustomTextStyle(
                        fontSize: 25,
                        color: const Color(0xff00cccc),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '(${estimateUser.estimates.length}',
                          style: CustomTextStyle(

                            fontSize: 13,
                            color: const Color(0xff000000),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        if (estimateUser.sumEstimates != null)
                          RatingBar(
                            rating: (double.parse(estimateUser.sumEstimates.sum_estimates) / estimateUser.estimates.length).toDouble(),
                            icon: Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.grey,
                            ),
                            starCount: 5,
                            spacing: 5.0,
                            size: 20,
                            isIndicator: true,
                            allowHalfRating: true,
                            color: Colors.amber,
                          )
                        else
                          RatingBar(
                            rating: 3,
                            icon: Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.grey,
                            ),
                            starCount: 5,
                            spacing: 5.0,
                            size: 20,
                            isIndicator: true,
                            allowHalfRating: true,
                            color: Colors.amber,
                          ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        AppLocalizations.of(context).estimate + ' (0.0) ',
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Text(
                            ' (0) ',
                            style: CustomTextStyle(

                              fontSize: 10,
                              color: const Color(0xff989696),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RatingBar(
                            rating: 3,
                            icon: Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.grey,
                            ),
                            starCount: 5,
                            spacing: 5.0,
                            size: 20,
                            isIndicator: true,
                            allowHalfRating: true,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          backgroundColor: Color(0xffdddddd),
          toolbarHeight: 110,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (estimateUser.estimates.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        for (var i = 0; i < estimateUser.estimates.length; i++)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: _lang != 'en_US'
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 15),
                                      child: RatingBar(
                                        rating: double.parse(
                                            estimateUser.estimates[i].rate),
                                        icon: Icon(
                                          Icons.star,
                                          size: 30,
                                          color: Colors.grey,
                                        ),
                                        starCount: 5,
                                        spacing: 5.0,
                                        size: 30,
                                        isIndicator: true,
                                        allowHalfRating: true,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: _lang != 'en_US'
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      estimateUser.estimates[i].comment,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xff989696),
                                      ).getTextStyle(),
                                      // textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Divider(
                                    color: const Color(0xffdddddd),
                                    height: 0,
                                    thickness: 2,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ]),
                )
              else
                Container(),
            ],
          ),
        ),
      );
    });
  }
}
