import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tadawl_app/models/ConvModel.dart';
import 'package:http/http.dart' as http;
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class ConversationModel extends ChangeNotifier {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ConvModel> _conversations = [];
  final List<ConvModel> _comments = [];
  List _ConversationsData = [];
  List _CommentData = [];

  void getConversationsList(BuildContext context, String Phone) {
    _conversations.clear();
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getDiscListFunc(Phone).then((value) {
        _ConversationsData = value;
        _ConversationsData.forEach((element) {
          _conversations.add(ConvModel.fromJson(element));
        });
      });
    });
    notifyListeners();
  }

  void getCommentsDiscussion(
      BuildContext context, String Phone, String OtherPhone) {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getComments(Phone, OtherPhone).then((value) {
        _CommentData = value;
        _CommentData.forEach((element) {
          _comments.add(ConvModel.fromJson(element));
        });
      });
    });
    notifyListeners();
  }

  Future<void> sendMess(String Phone, String OtherPhone, String content) async {
    await http.post(
        'https://www.tadawl.com.sa/API/api_app/conversations/send_mes.php',
        body: {
          'phone': Phone,
          'other_phone': OtherPhone,
          'message': content,
        });
    notifyListeners();
  }

  List<ConvModel> get conversations => _conversations;
  List<ConvModel> get comments => _comments;
}
