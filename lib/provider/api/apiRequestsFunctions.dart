import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequests {
  final String _token = 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@';
  String BaseURL = 'https://www.tadawl.com.sa/API/api_app';

  Future<dynamic> getUserRequestsListFunc(
       String Phone) async {
    var url = '$BaseURL/orders/get_user_requests.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': Phone,
    });
    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> getNotificationsFunc( String phone) async {
    var url = '$BaseURL/notifications/get_notifications.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone_user': phone,
    });
    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> changeNotificationStateFunc( String phone, String idNotification) async {
    var url = '$BaseURL/notifications/notification_seen.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone_user': phone,
      'id_notification': idNotification,
    });
    // var jsonx = json.decode(response.body);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }

  }
}
