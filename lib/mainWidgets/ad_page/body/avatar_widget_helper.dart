import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/avatar_widget.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class AvatarWidgetHelper extends StatelessWidget {
  const AvatarWidgetHelper({
    Key key,
    @required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types
    final MyAccountProvider myAccountProvider = MyAccountProvider(phone);
    return ChangeNotifierProvider<MyAccountProvider>(
      create: (_) => myAccountProvider,
      child: AvatarWidget(myAccountProvider: myAccountProvider),
    );
  }
}
