import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/update_my_information_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';
import 'package:cached_network_image/cached_network_image.dart';


class UpdateMyInformation extends StatelessWidget {
  UpdateMyInformation({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _updateMyInfoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final a = Provider.of<UserProvider>(context, listen: false);

    return Consumer2<UpdateMyInformationProvider, UserMutualProvider>(builder: (context, userUpdate, userMutual, child) {


      print("UpdateMyInformation -> UpdateMyInformationProvider");
      print("UpdateMyInformation -> UserMutualProvider");


      var mediaQuery = MediaQuery.of(context);

      return Scaffold(
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
                userMutual.getAvatarList(context, userMutual.phone);
                userMutual.getUserAdsList(context, userMutual.phone);
                userMutual.getEstimatesInfo(context, userMutual.phone);
                userMutual.getSumEstimatesInfo(context, userMutual.phone);
                userMutual.checkOfficeInfo(context, userMutual.phone);
                userMutual.getSession();

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context).updateMyInfo,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (userMutual.users.isEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: TextButton(
                                    onPressed: () {
                                      userUpdate.getImageUpdateProfile();
                                    },
                                    child: Container(
                                      width: mediaQuery.size.width * 0.9,
                                      height: mediaQuery.size.height * 0.3,
                                      child: Center(
                                          child: userUpdate
                                                      .imageUpdateProfile ==
                                                  null
                                              ? Container(
                                                  width: mediaQuery.size.width *
                                                      0.9,
                                                  height:
                                                      mediaQuery.size.height *
                                                          0.3,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: const AssetImage(
                                                          'assets/images/avatar.png'),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: mediaQuery.size.width *
                                                      0.9,
                                                  height:
                                                      mediaQuery.size.height *
                                                          0.4,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(userUpdate
                                                          .imageUpdateProfile),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )),
                                    ),
                                  ),
                                )
                              else
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: TextButton(
                                    onPressed: () {
                                      userUpdate.getImageUpdateProfile();
                                    },
                                    child: Container(
                                      width: mediaQuery.size.width * 0.9,
                                      height: mediaQuery.size.height * 0.3,
                                      child: Center(
                                          child: userUpdate
                                                      .imageUpdateProfile ==
                                                  null
                                              ? userMutual.users.first.image == '' || userMutual.users.first.image == null
                                                  ? Container(
                                                      width: mediaQuery
                                                              .size.width *
                                                          0.9,
                                                      height: mediaQuery
                                                              .size.height *
                                                          0.3,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: const AssetImage(
                                                              'assets/images/avatar.png'),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: mediaQuery
                                                              .size.width *
                                                          0.9,
                                                      height: mediaQuery
                                                              .size.height *
                                                          0.3,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              'https://tadawl.com.sa/API/assets/images/avatar/${userMutual.users.first.image}'),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    )
                                              : Container(
                                                  width: mediaQuery.size.width *
                                                      0.9,
                                                  height:
                                                      mediaQuery.size.height *
                                                          0.4,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(userUpdate
                                                          .imageUpdateProfile),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: mediaQuery.size.width * 0.8,
                                child: TextFormField(
                                  //controller: (userUpdate.usernameControllerUpdate..text) != null ? userUpdate.usernameController : userUpdate.usernameControllerUpdate,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xff00cccc),
                                        size: 40,
                                      ),
                                      labelText: AppLocalizations.of(context).name),
                                  initialValue: userMutual.users.first.username ?? '',
                                  style: CustomTextStyle(

                                    fontSize: 13,
                                    color: Color(0xff989696),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .reqName;
                                    }
                                    return null;
                                  },
                                  //onChanged: (String value) {
                                  //  userUpdate.setUsernameControllerUpdate(value);
                                  //},
                                  onSaved: (String value) {
                                    //userUpdate.setUsernameController(value);
                                    userMutual.setUsername(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: mediaQuery.size.width * 0.8,
                                child: TextFormField(
                                  //controller: userUpdate.emailController ?? TextEditingController(text: ''),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Color(0xff00cccc),
                                        size: 40,
                                      ),
                                      labelText:
                                          AppLocalizations.of(context).email),
                                  initialValue: userMutual.users.first.email ?? '',
                                  style: CustomTextStyle(

                                    fontSize: 13,
                                    color: Color(0xff989696),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .reqEmail;
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userMutual.setEmail(value);
                                    //userUpdate.setEmailController(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: mediaQuery.size.width * 0.8,
                                child: TextFormField(
                                  //controller: userUpdate.aboutController ?? TextEditingController(text: ''),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.message_rounded,
                                        color: Color(0xff00cccc),
                                        size: 40,
                                      ),
                                      labelText:
                                          AppLocalizations.of(context).aboutMe),
                                  initialValue: userMutual.users.first.about ?? '',
                                  style: CustomTextStyle(
                                    fontSize: 13,
                                    color: Color(0xff989696),
                                  ).getTextStyle(),
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)
                                          .reqField;
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    userMutual.setPersonalProfile(value);
                                    //userUpdate.setAboutController(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                          AppLocalizations.of(context).marketer,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          AppLocalizations.of(context).owner,
                                          style: CustomTextStyle(
                                            fontSize: 15,
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          AppLocalizations.of(context).reSeeker,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .officeType,
                                          style: CustomTextStyle(
                                            fontSize: 15,
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                    onPressed: (int index) {
                                      userMutual.updateMembershipType(index);
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: mediaQuery.size.width * 0.8,
                                  child: TextFormField(
                                    //controller: userUpdate.companyNameController ?? TextEditingController(text: ''),
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.business,
                                          color: Color(0xff00cccc),
                                          size: 40,
                                        ),
                                        labelText: AppLocalizations.of(context).companyName),
                                    style: CustomTextStyle(
                                      fontSize: 13,
                                      color: Color(0xff989696),
                                    ).getTextStyle(),
                                    keyboardType: TextInputType.text,
                                    initialValue: userMutual.users.first.company_name ?? '',
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .reqField;
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      userMutual.setCompanyName(value);
                                      //userUpdate.setCompanyNameController(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          if (userMutual.selectedMembership == 5)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: mediaQuery.size.width * 0.8,
                                  child: TextFormField(
                                    //controller: userUpdate.OfficeNameController ?? TextEditingController(text: ''),
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.text_snippet_rounded,
                                          color: Color(0xff00cccc),
                                          size: 40,
                                        ),
                                        labelText: AppLocalizations.of(context)
                                            .officeTypeName),
                                    style: CustomTextStyle(
                                      fontSize: 13,
                                      color: Color(0xff989696),
                                    ).getTextStyle(),
                                    keyboardType: TextInputType.text,
                                    initialValue: userMutual.users.first.office_name ?? '',
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .reqField;
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      userMutual.setOfficeNameUser(value);
                                      //userUpdate.setOfficeNameController(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                            child: TextButton(
                              onPressed: () async {
                                if (!_updateMyInfoKey.currentState.validate()) {
                                  return;
                                }
                                _updateMyInfoKey.currentState.save();
                                await userUpdate.updateMyProfile(
                                    context,
                                    userMutual.selectedMembership.toString(),
                                    userMutual.userName,
                                    userMutual.company_name,
                                    userMutual.officeNameUser,
                                    userMutual.email,
                                    userMutual.personalProfile,
                                    userMutual.phone,
                                    userUpdate.imageUpdateProfile);
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
                                    AppLocalizations.of(context).save,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
