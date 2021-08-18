import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tadawl_app/models/NotificationModel.dart';
import 'package:tadawl_app/provider/api/apiRequestsFunctions.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  FlutterLocalNotificationsPlugin _localNotification;

  Future<void> getNotificationsList(String phone) async {
    Future.delayed(Duration(milliseconds: 0), () async{
      if(phone != null) {
        _notifications.clear();
        List<dynamic> value = await ApiRequests().getNotificationsFunc(phone);
        value.forEach((element) {
          _notifications.add(NotificationModel.fromJson(element));
        });
      }
    });
  }



  Future<void> changeNotificationState( String phone, String idNotification) async{
    await ApiRequests().changeNotificationStateFunc(phone, idNotification);
  }

  Future showNotification( String phone) async {
    if (_notifications.isNotEmpty) {
      _notifications.forEach((notifications) async{
        if (notifications.state == '1') {
          if (notifications.seen == '0') {

            await changeNotificationState(phone, notifications.id_notification);
            var androidDetails = AndroidNotificationDetails(
                'ChannelId',
                'Local Notification',
                'This is the description of the Notification, you can write anything',
                importance: Importance.high);
            var iosDetails = IOSNotificationDetails();
            var generalNotificationDetails =
            NotificationDetails(android: androidDetails, iOS: iosDetails);
            await _localNotification.show(
                int.parse(notifications.id_notification),
                '${notifications.title}',
                '${notifications.body}',
                generalNotificationDetails);
          }
          else {}
        }
      });
    }

    var androidInitialize = AndroidInitializationSettings('ic_launcher');
    var iosInitialize = IOSInitializationSettings();
    var initializationSettings =
    InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    _localNotification = FlutterLocalNotificationsPlugin();
    await _localNotification.initialize(initializationSettings);
  }

  // void setChatNotification( String phone, String other_phone, String title, String body){
  //   Future.delayed(Duration(milliseconds: 0), () {
  //     if(phone != null) {
  //       _notifications.add(NotificationModel(
  //         phone_user: phone,
  //         response_phone_user: other_phone,
  //         title: title,
  //         body: body,
  //         state: '1',
  //         seen: '0',
  //       ));
  //     }
  //   });
  // }

  List<NotificationModel> get notifications => _notifications;
}
