import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/update_my_information/update_Info_image.dart';
import 'package:tadawl_app/mainWidgets/update_my_information/update_info_mem_type.dart';
import 'package:tadawl_app/mainWidgets/update_my_information/update_info_text_field.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';


class UpdateMyInformation extends StatelessWidget {
  UpdateMyInformation({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _updateMyInfoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
          return WillPopScope(
            onWillPop: () async{
              Provider.of<UserMutualProvider>(context, listen: false).clearUpdatingInformation();
              return true;
            },
            child: Scaffold(
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
                      // userMutual.getAvatarList(context, userMutual.phone);
                      // userMutual.getUserAdsList(context, userMutual.phone);
                      // userMutual.getEstimatesInfo(context, userMutual.phone);
                      // userMutual.getSumEstimatesInfo(context, userMutual.phone);
                      // userMutual.checkOfficeInfo(context, userMutual.phone);
                      // userMutual.getSession();
                      Provider.of<UserMutualProvider>(context, listen: false).clearUpdatingInformation();
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                title: Text(
                  AppLocalizations
                      .of(context)
                      .updateMyInfo,
                  style: CustomTextStyle(

                    fontSize: 20,
                    color: const Color(0xffffffff),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color(0xff00cccc),
              ),
              backgroundColor: Color(0xffffffff),
              body: Form(
                key: _updateMyInfoKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                UpdateInfoImage(),
                                UpdateInfoTextField(
                                  labelText: AppLocalizations.of(context).name,
                                  fieldType: FieldType.username,
                                  icon: Icons.person,
                                ),
                                UpdateInfoTextField(
                                  labelText: AppLocalizations.of(context).email,
                                  fieldType: FieldType.email,
                                  icon: Icons.email_outlined,
                                ),
                                UpdateInfoTextField(
                                  labelText: AppLocalizations.of(context).aboutMe,
                                  fieldType: FieldType.about,
                                  icon: Icons.message_rounded,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 15, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context).memType,
                                        style: CustomTextStyle(
                                          fontSize: 15,
                                          color: Color(0xff989696),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                                UpdateInfoMemType(_updateMyInfoKey)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}