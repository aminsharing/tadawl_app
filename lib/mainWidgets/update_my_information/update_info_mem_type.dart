import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/update_my_information/update_info_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class UpdateInfoMemType extends StatelessWidget {
  const UpdateInfoMemType(this._updateMyInfoKey,{Key key}) : super(key: key);
  final GlobalKey<FormState> _updateMyInfoKey;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MyAccountProvider>(builder: (context, userMutual, child) {
      if(!userMutual.membershipType.contains(true)){
        userMutual.updateMembershipType(int.tryParse(userMutual.users.id_mem), false);
      }

      return Column(
        children: [
          Container(
            width: mediaQuery.size.width,
            height: 70.0,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations.of(context).company,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .marketer,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .owner,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .reSeeker,
                          style: CustomTextStyle(

                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .officeType,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      userMutual.updateMembershipType(index, true);
                    },
                    isSelected: userMutual.membershipType,
                    color: Color(0xff00cccc),
                    selectedColor: Color(0xffffffff),
                    fillColor: Color(0xff00cccc),
                    borderWidth: 1,
                    borderColor: Color(0xff00cccc),
                    selectedBorderColor: Color(0xff00cccc),
                  ),
                ),
              ],
            ),
          ),
          if (userMutual.selectedMembership == 1)
            UpdateInfoTextField(
              labelText: AppLocalizations.of(context).companyName,
              fieldType: FieldType.companyName,
              icon: Icons.business,
            ),
          if (userMutual.selectedMembership == 5)
            UpdateInfoTextField(
              labelText: AppLocalizations.of(context).officeTypeName,
              fieldType: FieldType.officeTypeName,
              icon: Icons.text_snippet_rounded,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 30, 0, 30),
            child: TextButton(
              onPressed: () async {
                if (!_updateMyInfoKey.currentState.validate()) {
                  return;
                }
                _updateMyInfoKey.currentState.save();
                await userMutual
                    .updateMyProfile(
                    context,
                    userMutual.selectedMembership,
                    userMutual.userName,
                    userMutual.company_name,
                    userMutual.officeNameUser,
                    userMutual.email,
                    userMutual.personalProfile,
                    locale.phone,
                    userMutual.imageUpdateProfile);
              },
              child: Container(
                width: mediaQuery.size.width * 0.5,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Color(0xff3f9d28), width: 1),
                  color: Color(0xff3f9d28),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .save,
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: Color(0xffffffff),
                    ).getTextStyle(),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
