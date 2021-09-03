import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';

class MsgBottomButton extends StatelessWidget {
  const MsgBottomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MsgProvider>(builder: (context, mainChat, child) {
      return mainChat.atBottom
          ?
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 100),
        child: FloatingActionButton(
            backgroundColor: Color(0xff00cccc),
            onPressed: () {
              mainChat.scrollDownButtun();
            },
            child: Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: Color(0xffffffff),
              size: 40,
            )),
      )
          :
      Container();
    });
  }
}
