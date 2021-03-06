import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/ConvModel.dart';

class ConvBtn extends StatelessWidget {
  const ConvBtn({
    Key? key,
    required this.conv,
    required this.phone,
    required this.onPressed,
  }) : super(key: key);
  final GestureTapCallback? onPressed;
  final ConvModel conv;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        // margin: EdgeInsets.only(right: 10, bottom: 5, top: 5, left: 10),
        padding: EdgeInsets.only(top: 0, left: 13, right: 0, bottom: 13),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: Colors.grey),
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Container(
                      width: mediaQuery.size.width * .22,
                      height: mediaQuery.size.width * .22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: ((conv.image??'').isNotEmpty
                                ?
                            CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/avatar/${conv.image ?? 'avatar.jpg'}')
                                :
                            AssetImage('assets/images/avatar.png')) as ImageProvider,
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conv.username ?? 'UserName',
                        style: CustomTextStyle(
                          fontSize: 17,
                          color: Color(0xff00cccc),
                        ).getTextStyle(),
                      ),
                      Text(
                        conv
                            .comment ??
                            '',
                        style: CustomTextStyle(
                          fontSize: 13,
                          // color: Colors.white54,
                          color: Color(0xff848282),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets
                                .fromLTRB(
                                5,
                                0,
                                15,
                                0),
                            child: Text(
                              DateTime.now().difference(DateTime.parse(conv.timeAdded!)).inDays > 0
                                  ?
                              DateFormat('yyyy-MM-dd')
                                  .format(
                                DateTime.parse(conv.timeAdded!),
                              )
                                  :
                              DateFormat('hh:mm a')
                                  .format(
                                DateTime.parse(conv.timeAdded!),
                              ),
                              style: TextStyle(
                                fontFamily:
                                'DINNext',

                                fontSize: 10,
                                // color: Colors
                                //     .black45,
                                color: Color(0xff848282),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if(conv.unreadMsgs != '0' && conv.unreadMsgs != null)
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration:
                          BoxDecoration(
                              color: Colors.green.withOpacity(0.7),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '${conv.unreadMsgs}',
                              style: TextStyle(
                                fontFamily:
                                'DINNext',
                                fontSize: 13,
                                color: Color(0xff848282),
                                // color:
                                // conv.phone_user_sender == _phone
                                //         ? Color(0xff848282)
                                //         : Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}