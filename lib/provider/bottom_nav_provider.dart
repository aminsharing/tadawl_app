import 'package:flutter/cupertino.dart';

class BottomNavProvider extends ChangeNotifier{
  BottomNavProvider(){
    print('init BottomNavProvider');
  }

  @override
  void dispose() {
    print('dispose BottomNavProvider');
    super.dispose();
  }

  int _currentPage = 0;

  void setCurrentPage(int val){
    _currentPage = val;
  }


  int get currentPage => _currentPage;

}