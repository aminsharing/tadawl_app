// this file has been remove and replace it by contact_wp.dart file

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/general_provider.dart';

String patternPhone =
    r'(^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';
RegExp regExpPhone = RegExp(patternPhone);

class Contact extends StatelessWidget {
  Contact({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> _formContactKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<GeneralProvider>(context, listen: false);
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
            AppLocalizations.of(context)!.contactUs,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Form(
            key: _formContactKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ContactTextField(
                    text: AppLocalizations.of(context)!.name,
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      contact.setName(value??'');
                    },
                    validator: (String? value) {
                      if ((value??'').isEmpty) {
                        return AppLocalizations.of(context)!.reqName;
                      }
                      return null;
                    },
                ),
                ContactTextField(
                  text: AppLocalizations.of(context)!.mobileNumber,
                  keyboardType: TextInputType.number,
                  onSaved: (String? value) {
                    contact.filterPhone(value??'');
                  },
                  validator: (String? value) {
                    if ((value??'').isEmpty) {
                      return AppLocalizations.of(context)!.reqMob;
                    } else if (!regExpPhone.hasMatch((value??''))) {
                      return AppLocalizations.of(context)!.reqSaudiMob;
                    }
                    return null;
                  },
                ),
                ContactTextField(
                  text: AppLocalizations.of(context)!.title,
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    contact.setTitle(value??'');
                  },
                  validator: (String? value) {
                    if ((value??'').isEmpty) {
                      return AppLocalizations.of(context)!.reqTitle;
                    }
                    return null;
                  },
                ),
                ContactTextField(
                  text: AppLocalizations.of(context)!.message,
                  keyboardType: TextInputType.text,
                  onSaved: (String? value) {
                    contact.setDetails(value??'');
                  },
                  validator: (String? value) {
                    if ((value??'').isEmpty) {
                      return AppLocalizations.of(context)!.reqMess;
                    }
                    return null;
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Text(
                //       AppLocalizations.of(context).name,
                //       style: CustomTextStyle(
                //
                //         fontSize: 15,
                //         color: const Color(0xff000000),
                //       ).getTextStyle(),
                //       textAlign: TextAlign.right,
                //       textDirection: TextDirection.rtl,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: AppLocalizations.of(context).name,
                //       fillColor: const Color(0xff989696),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(),
                //       ),
                //     ),
                //     style: CustomTextStyle(
                //       fontSize: 13,
                //       color: const Color(0xff989696),
                //     ).getTextStyle(),
                //     keyboardType: TextInputType.text,
                //     minLines: 1,
                //     maxLines: 1,
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return AppLocalizations.of(context).reqName;
                //       }
                //       return null;
                //     },
                //     onSaved: (String value) {
                //       contact.setName(value);
                //     },
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Text(
                //       AppLocalizations.of(context).mobileNumber,
                //       style: CustomTextStyle(
                //         fontSize: 15,
                //         color: const Color(0xff000000),
                //       ).getTextStyle(),
                //       textAlign: TextAlign.right,
                //       textDirection: TextDirection.rtl,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: AppLocalizations.of(context).mobileNumber,
                //       fillColor: const Color(0xff989696),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(),
                //       ),
                //     ),
                //     style: CustomTextStyle(
                //
                //       fontSize: 13,
                //       color: const Color(0xff989696),
                //     ).getTextStyle(),
                //     keyboardType: TextInputType.number,
                //     minLines: 1,
                //     maxLines: 1,
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return AppLocalizations.of(context).reqMob;
                //       } else if (!regExpPhone.hasMatch(value)) {
                //         return AppLocalizations.of(context).reqSaudiMob;
                //       }
                //       return null;
                //     },
                //     onSaved: (String value) {
                //       contact.filterPhone(value);
                //     },
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Text(
                //       AppLocalizations.of(context).title,
                //       style: CustomTextStyle(
                //
                //         fontSize: 15,
                //         color: const Color(0xff000000),
                //       ).getTextStyle(),
                //       textAlign: TextAlign.right,
                //       textDirection: TextDirection.rtl,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: AppLocalizations.of(context).title,
                //       fillColor: const Color(0xff989696),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(),
                //       ),
                //     ),
                //     style: CustomTextStyle(
                //
                //       fontSize: 13,
                //       color: const Color(0xff989696),
                //     ).getTextStyle(),
                //     keyboardType: TextInputType.text,
                //     minLines: 1,
                //     maxLines: 1,
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return AppLocalizations.of(context).reqTitle;
                //       }
                //       return null;
                //     },
                //     onSaved: (String value) {
                //       contact.setTitle(value);
                //     },
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Text(
                //       AppLocalizations.of(context).message,
                //       style: CustomTextStyle(
                //
                //         fontSize: 15,
                //         color: const Color(0xff000000),
                //       ).getTextStyle(),
                //       textAlign: TextAlign.right,
                //       textDirection: TextDirection.rtl,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: AppLocalizations.of(context).message,
                //       fillColor: Colors.white,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: BorderSide(),
                //       ),
                //     ),
                //     style: CustomTextStyle(
                //
                //       fontSize: 13,
                //       color: const Color(0xff989696),
                //     ).getTextStyle(),
                //     keyboardType: TextInputType.text,
                //     minLines: 4,
                //     maxLines: 4,
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return AppLocalizations.of(context).reqMess;
                //       }
                //       return null;
                //     },
                //     onSaved: (String value) {
                //       contact.setDetails(value);
                //     },
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 15, 100, 30),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff00cccc),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff00cccc)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (!_formContactKey.currentState!.validate()) {
                          return;
                        }
                        _formContactKey.currentState!.save();
                        contact.sendForm(context, contact.name, contact.mobile,
                            contact.title, contact.details);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.send,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
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


class ContactTextField extends StatelessWidget {
  const ContactTextField({
    Key? key,
    required this.text,
    required this.keyboardType,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);
  final String text;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: text,
              fillColor: const Color(0xff989696),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
            ),
            style: CustomTextStyle(
              fontSize: 13,
              color: const Color(0xff989696),
            ).getTextStyle(),
            keyboardType: keyboardType,
            minLines: text == AppLocalizations.of(context)!.message ? 4 : 1,
            maxLines: text == AppLocalizations.of(context)!.message ? 4 : 1,
            validator: validator,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}
