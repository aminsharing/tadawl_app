import 'package:flutter/cupertino.dart';

class BottomNavProvider extends ChangeNotifier{
  int _currentPage = 0;

  void setCurrentPage(int val){
    _currentPage = val;
  }


  int get currentPage => _currentPage;
}