import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/aqar_vr_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';

class AqarVR extends StatelessWidget {
  AqarVR({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _aqarVRKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      var mediaQuery = MediaQuery.of(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).reVR,
            style: CustomTextStyle(
              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff00cccc),
          toolbarHeight: 70.0,
          centerTitle: true,
          leadingWidth: 70.0,
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Form(
            key: _aqarVRKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).rule35,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Consumer<AqarVRProvider>(builder: (context, aqarVR, child) {
                  print("AqarVR -> AqarVRProvider");
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).saqNumber,
                              style: CustomTextStyle(
                                fontSize: 11,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: mediaQuery.size.width * 0.5,
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).enterSaqNumber),
                                  style: CustomTextStyle(
                                    fontSize: 10,
                                    color: const Color(0xffababab),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      aqarVR.setButtonClickedAqarVR(null);
                                      return AppLocalizations.of(context).reqSaqNumber;
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    aqarVR.setSaqNumber(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // image start
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).saqImage,
                              style: CustomTextStyle(
                                fontSize: 11,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      aqarVR.getImageAqarVR();
                                    },
                                    child: Container(
                                      width: mediaQuery.size.width * 0.5,
                                      height: mediaQuery.size.height * 0.3,
                                      child: Center(
                                        child: Container(
                                          width: mediaQuery.size.width * 0.6,
                                          height: mediaQuery.size.height * 0.25,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: aqarVR.imageAqarVR == null
                                                  ?
                                              const AssetImage('assets/images/img4.png')
                                                  :
                                              FileImage(aqarVR.imageAqarVR),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // image end

                      // id type start
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).idType,
                              style: CustomTextStyle(
                                fontSize: 11,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: mediaQuery.size.width,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ToggleButtons(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(context).commRec,
                                            style: CustomTextStyle(

                                              fontSize: 10,
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .accommodation,
                                            style: CustomTextStyle(
                                                fontSize: 10).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .nationalIdentity,
                                            style: CustomTextStyle(

                                              fontSize: 10,
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        aqarVR.updateIdentityType(index);
                                      },
                                      isSelected: aqarVR.list_id_type,
                                      color: const Color(0xff00cccc),
                                      selectedColor: const Color(0xffffffff),
                                      fillColor: const Color(0xff00cccc),
                                      borderColor: const Color(0xff00cccc),
                                      selectedBorderColor: const Color(0xff00cccc),
                                      borderWidth: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // id type end
                      // id textField start
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context).idSaq,
                                style: CustomTextStyle(
                                  fontSize: 8,
                                  color: const Color(0xff000000),
                                ).getTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: mediaQuery.size.width * 0.6,
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).enterIDSaq),
                                  style: CustomTextStyle(

                                    fontSize: 8,
                                    color: const Color(0xffababab),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      aqarVR.setButtonClickedAqarVR(null);
                                      return AppLocalizations.of(context).reqIDSaq;
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    aqarVR.setIdentityNumber(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // id textField end
                      if (aqarVR.buttonClickedAqarVR == null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                          child: TextButton(
                            onPressed: () async {
                              aqarVR.setButtonClickedAqarVR(1);
                              if (!_aqarVRKey.currentState.validate()) {
                                return;
                              }
                              _aqarVRKey.currentState.save();
                              if (aqarVR.imageAqarVR == null) {
                                await Fluttertoast.showToast(
                                    msg: 'صورة الصك مطلوبة',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 15.0);
                                aqarVR.setButtonClickedAqarVR(null);
                              }
                              else {
                                await aqarVR.sendInfoAqarVR(
                                    context,
                                    aqarVR.identity_number,
                                    aqarVR.saq_number,
                                    aqarVR.identity_type,
                                    Provider.of<MutualProvider>(context, listen: false).idDescription,
                                    aqarVR.imageAqarVR);
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: const Color(0xff00cccc), width: 1),
                                color: const Color(0xffffffff),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context).reqVR,
                                  style: CustomTextStyle(
                                    fontSize: 15,
                                    color: const Color(0xff00cccc),
                                  ).getTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (aqarVR.buttonClickedAqarVR == 1)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                          child: Container(
                            width: 150,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xff989898), width: 1),
                              color: const Color(0xffffffff),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).reqVR,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff989898),
                                ).getTextStyle(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
  }
}
