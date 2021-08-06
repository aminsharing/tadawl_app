import 'package:flutter/cupertino.dart';

class BottomNavProvider extends ChangeNotifier{
  BottomNavProvider(){
    print("BottomNavProvider init");
  }

  @override
  void dispose() {
    print("BottomNavProvider dispose");
    super.dispose();
  }

  int _currentPage = 0;

  void setCurrentPage(int val){
    _currentPage = val;
  }


  int get currentPage => _currentPage;

}