import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/offices_vr/stage_1.dart';
import 'package:tadawl_app/provider/user_provider/offices_vr_provider.dart';

class Stage0 extends StatelessWidget {
  Stage0({Key key}) : super(key: key);
  final GlobalKey<FormState> _officesVRKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);
    final mediaQuery = MediaQuery.of(context);
    final officesVR = Provider.of<OfficesVRProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          translate.officesAccreditation,
          style: CustomTextStyle(
            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff1f2835),
      ),
      backgroundColor: const Color(0xffffffff),
      body: Form(
        key: _officesVRKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate
                          .realEstateOfficesName,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: BuildOfficeTextField(
                  keyboardType: TextInputType.text,
                  labelText: translate.realEstateOfficesName,
                  onSaved: (value){
                    officesVR.setOfficeName(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      officesVR.setButtonClicked(null);
                      return translate.reqRealEstateOfficesName;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate.sejelNumber,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: BuildOfficeTextField(
                  keyboardType: TextInputType.number,
                  labelText: translate.enterSejel10,
                  validator: (String value) {
                    if (value.isEmpty) {
                      officesVR.setButtonClicked(null);
                      return translate.reqSejel;
                    } else if (value.length < 10) {
                      officesVR.setButtonClicked(null);
                      return translate.reqLess10Sejel;
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    officesVR.setCRNumber(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        translate.sejelImage,
                        style: CustomTextStyle(
                          fontSize: 13,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      officesVR.getImageOfficesVR();
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.9,
                      height: mediaQuery.size.height * 0.3,
                      child: Center(
                        child: Consumer<OfficesVRProvider>(builder: (context, officesVROn, child) {
                          return Container(
                            width: mediaQuery.size.width * 0.9,
                            height: mediaQuery.size.height * 0.3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                officesVROn.imageOfficeVR == null
                                    ?
                                const AssetImage('assets/images/img4.png')
                                    :
                                FileImage(officesVROn.imageOfficeVR),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: TextButton(
                  onPressed: () async {
                    if (!_officesVRKey.currentState.validate()) {
                      return;
                    }
                    _officesVRKey.currentState.save();
                    if (officesVR.imageOfficeVR == null) {
                      await Fluttertoast.showToast(
                          msg: 'صورة السجل التجاري مطلوبة',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                    } else {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ChangeNotifierProvider<OfficesVRProvider>.value(
                            value: OfficesVRProvider(),
                            child: Stage1(
                              CRNumber: officesVR.CRNumber,
                              officeName: officesVR.officeName,
                              imageOfficeVR: officesVR.imageOfficeVR,
                            ),
                          ),
                      ));
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
                        translate.next,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildOfficeTextField extends StatelessWidget {
  const BuildOfficeTextField({
    Key key,
    @required this.labelText,
    @required this.validator,
    @required this.onSaved,
    @required this.keyboardType,
  }) : super(key: key);
  final String labelText;
  final Function(String) validator;
  final Function(String) onSaved;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      style: CustomTextStyle(
        fontSize: 15,
        color: const Color(0xffababab),
      ).getTextStyle(),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
