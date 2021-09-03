import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tadawl_app/models/requestModel.dart';
import 'package:tadawl_app/provider/api/apiRequestsFunctions.dart';

class RequestProvider extends ChangeNotifier {
  RequestProvider(){
    print('init RequestProvider');
  }
  @override
  void dispose() {
    print('dispose RequestProvider');
    super.dispose();
  }

  final List<RequestModel> _requests = [];
  List? __requestsData = [];


  void getUserRequestsList(String? Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_requests.isEmpty) {
        ApiRequests()
            .getUserRequestsListFunc(Phone)
            .then((value) {
          __requestsData = value;
          __requestsData!.forEach((element) {
            _requests.add(RequestModel.fromJson(element));
          });
        });
      } else {
        ApiRequests()
            .getUserRequestsListFunc(Phone)
            .then((value) {
          __requestsData = value;
          _requests.clear();
          __requestsData!.forEach((element) {
            _requests.add(RequestModel.fromJson(element));
          });
        });
      }
    });
  }

  int countRequests() {
    if (_requests.isNotEmpty) {
      return _requests.length;
    } else {
      return 0;
    }
  }

  List<RequestModel> get requests => _requests;
}
