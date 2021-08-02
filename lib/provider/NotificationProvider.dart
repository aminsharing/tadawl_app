import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tadawl_app/models/NotificationModel.dart';
import 'package:tadawl_app/provider/api/apiRequestsFunctions.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  FlutterLocalNotificationsPlugin _localNotification;

  Future<void> getNotificationsList( String phone) async {
    Future.delayed(Duration(milliseconds: 0), () async{
      if(phone != null) {
        if (_notifications.isEmpty) {
          List<dynamic> value = await ApiRequests().getNotificationsFunc(phone);
          value.forEach((element) {
            _notifications.add(NotificationModel.fromJson(element));
          });
        }
        else {
          List<dynamic> value = await ApiRequests().getNotificationsFunc(phone);
          _notifications.clear();
          value.forEach((element) {
            _notifications.add(NotificationModel.fromJson(element));
          });
        }
      }
    });
  }

  void changeNotificationState( String phone, String idNotification) {
    Future.delayed(Duration(milliseconds: 0), () {
        ApiRequests().changeNotificationStateFunc(phone, idNotification);
    });
  }

  int countNotifications() {
    if (_notifications.isNotEmpty) {
      return _notifications.length;
    } else {
      return 0;
    }
  }

  Future showNotification( String phone) async {
    if (_notifications.isNotEmpty) {
      for (var i = 0; i < countNotifications(); i++) {
        if (_notifications[i].state == '1') {
          if (_notifications[i].seen == '0') {
            changeNotificationState(phone, _notifications[i].id_notification);
            var androidDetails = AndroidNotificationDetails(
                'ChannelId',
                'Local Notification',
                'This is the description of the Notification, you can write anything',
                importance: Importance.high);
            var iosDetails = IOSNotificationDetails();
            var generalNotificationDetails =
            NotificationDetails(android: androidDetails, iOS: iosDetails);
            await _localNotification.show(
                int.parse(_notifications[i].id_notification),
                '${_notifications[i].title}',
                '${_notifications[i].body}',
                generalNotificationDetails);
          } else {}
        }
      }
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
