import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/general_provider.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(builder: (context, privacyPolicy, child) {

      print("PrivacyPolicy -> GeneralProvider");

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
            AppLocalizations.of(context).privacyPolicy,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Text(
                        'اتفاقية شروط استخدام موقع تطبيق تداول العقاري',
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'أهلا بك في تطبيق تداول العقاري باستعمالك لهذا التطبيق، فإنك توافق على أن تتقيد وتلتزم بالشروط والأحكام التالية لذا، يرجى منك الاطلاع على هذه الأحكام بدقة. أن كنت لا توافق على هذه الأحكام، فعليك ألا تتطلع على المعلومات المتوفرة في التطبيق',
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(0xff000000),
                          ).getTextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    privacyPolicy.setExpanded(index, isExpanded);
                  },
                  children: privacyPolicy.data.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              item.headerValue,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                            item.expandedValue,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff000000),
                            ).getTextStyle(),
                          ),
                        ),
                        isExpanded: item.isExpanded);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
