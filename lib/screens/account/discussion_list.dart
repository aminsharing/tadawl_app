import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/discussion/conv_btn.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'discussion_edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscussionList extends StatelessWidget {
  DiscussionList({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    // ignore: omit_local_variable_types
    final MsgProvider msgProvider = MsgProvider(context, locale.phone);
    return ChangeNotifierProvider<MsgProvider>(
      create: (_) => msgProvider,
      builder: (context, _){
        return Consumer<MsgProvider>(builder: (context, convList, child) {
          return Scaffold(
            backgroundColor: const Color(0xffffffff),
            drawer: Drawer(
              child: CustomDrawer(),
            ),
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 65.0,
              leadingWidth: 100,
              backgroundColor: const Color(0xff3d4653),
              leading: Container(),
              title: Text(
                AppLocalizations.of(context).messages,
                style: CustomTextStyle(
                  fontSize: 20,
                  color: const Color(0xffffffff),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  child: Icon(
                    Icons.edit,
                    color: const Color(0xff04B404),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          ChangeNotifierProvider<MsgProvider>.value(
                            value: msgProvider,
                            child: DiscussionEdit(msgProvider: msgProvider),
                          )
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height, // convList.countConvs()
              child: convList.conv.isNotEmpty
                  ?
              ListView.builder(
                itemCount: convList.conv.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, i){
                  if (convList.conv[i].state_conv_sender != '0'){
                    return ConvBtn(
                      conv: convList.conv[i],
                      phone: locale.phone,
                      onPressed: () {
                        // convList.initScrollDown();
                        convList.setReadMsgs(locale.phone, convList.conv[i].phone).then((value) {
                          convList.getUnreadMsgs(locale.phone).then((value) {
                            convList.update();
                            locale.getUnreadMsgs(locale.phone);
                            Future.delayed(Duration(seconds: 1), (){
                              locale.update();
                            });
                          });
                        });
                        convList.setRecAvatarUserName(convList.conv[i].username);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider<MsgProvider>.value(
                              value: msgProvider,
                              child: Discussion(
                                convList.conv[i].phone,
                                username: convList.conv[i].username,
                              ),
                            )
                        ),
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              )
                  :
              !convList.noMsgs
                  ?
              Center(
                child: Text(
                  AppLocalizations.of(context).noMessages,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: Color(0xff848282),
                  ).getTextStyle(),
                ),
              )
                  :
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff00cccc),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff1f2835)),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
                height: mediaQuery.size.height * 0.11,
                child: BottomNavigationBarApp()),
          );
        });
      },
    );
  }
}


