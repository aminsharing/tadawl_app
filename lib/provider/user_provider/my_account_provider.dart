import 'package:flutter/material.dart';

class MyAccountProvider extends ChangeNotifier{
  final List<bool> _isSelected = List.generate(2, (_) => false);
  int _selectedNav = 0;
  int _expendedListCount = 4;


  void clearExpendedListCount(){
    _expendedListCount = 4;
  }

  void updateSelected(int index) {
    for (var buttonIndex = 0; buttonIndex < countIsSelected(); buttonIndex++) {
      if (buttonIndex == index) {
        _isSelected[buttonIndex] = true;
        _selectedNav = buttonIndex;
      } else {
        _isSelected[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setExpendedListCount(int val){
    _expendedListCount = val;
    notifyListeners();
  }

  int countIsSelected() {
    if (_isSelected.isNotEmpty) {
      return _isSelected.length;
    } else {
      return 0;
    }
  }

  void initStateSelected() {
    _isSelected[0] = true;
  }



  List<bool> get isSelected => _isSelected;
  int get selectedNav => _selectedNav;
  int get expendedListCount => _expendedListCount;







}