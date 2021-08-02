import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';


class BuildSpace extends StatelessWidget {
  const BuildSpace({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final searchDrawer = Provider.of<MainPageProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).maxSpace,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(),
                ),
              ),
              style: CustomTextStyle(

                fontSize: 10,
                color: const Color(0xff989696),
              ).getTextStyle(),
              keyboardType: TextInputType.number,
              minLines: 1,
              maxLines: 1,
              onSaved: (String value) {
                searchDrawer.setMaxSpaceSearchDrawer(value);
              },
            ),
          ),
          Text(
            ' - ',
            style: CustomTextStyle(

              fontSize: 15,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).minSpace,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(),
                ),
              ),
              style: CustomTextStyle(

                fontSize: 10,
                color: const Color(0xff989696),
              ).getTextStyle(),
              keyboardType: TextInputType.number,
              minLines: 1,
              maxLines: 1,
              onSaved: (String value) {
                searchDrawer.setMinSpaceSearchDrawer(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}