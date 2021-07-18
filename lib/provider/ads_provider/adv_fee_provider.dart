import 'package:flutter/material.dart';

class AdvFeeProvider extends ChangeNotifier{
  final List<bool> _isSelected1 = List.generate(3, (_) => false);
  int _selectedNav1;
  final List<bool> _isSelected2 = List.generate(3, (_) => false);
  int _selectedNav2;
  final List<bool> _isSelected3 = List.generate(2, (_) => false);
  int _selectedNav3;
  final List<bool> _isSelected4 = List.generate(1, (_) => false);
  int _selectedNav4;


  void updateSelected1(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _isSelected1.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _isSelected1[buttonIndex] = true;
        _selectedNav1 = buttonIndex;
      } else {
        _isSelected1[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected2(int index) {
    for (var buttonIndex2 = 0;
    buttonIndex2 < _isSelected2.length;
    buttonIndex2++) {
      if (buttonIndex2 == index) {
        _isSelected2[buttonIndex2] = true;
        _selectedNav2 = buttonIndex2;
      } else {
        _isSelected2[buttonIndex2] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected3(int index) {
    for (var buttonIndex3 = 0;
    buttonIndex3 < _isSelected3.length;
    buttonIndex3++) {
      if (buttonIndex3 == index) {
        _isSelected3[buttonIndex3] = true;
        _selectedNav3 = buttonIndex3;
      } else {
        _isSelected3[buttonIndex3] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected4(int index) {
    for (var buttonIndex4 = 0;
    buttonIndex4 < _isSelected4.length;
    buttonIndex4++) {
      if (buttonIndex4 == index) {
        _isSelected4[buttonIndex4] = true;
        _selectedNav4 = buttonIndex4;
      } else {
        _isSelected4[buttonIndex4] = false;
      }
    }
    notifyListeners();
  }

  void updateSelectedNav4(int index) {
    _selectedNav4 = index;
    notifyListeners();
  }

  void initStateSelected() {
    _isSelected1[0] = true;
    _isSelected2[0] = true;
    _isSelected3[0] = true;
    _isSelected4[0] = true;
    _selectedNav1 = 0;
    _selectedNav2 = 0;
    _selectedNav3 = 0;
    _selectedNav4 = 0;
  }

  List<bool> get isSelected1 => _isSelected1;
  List<bool> get isSelected2 => _isSelected2;
  List<bool> get isSelected3 => _isSelected3;
  List<bool> get isSelected4 => _isSelected4;
  int get selectedNav1 => _selectedNav1;
  int get selectedNav2 => _selectedNav2;
  int get selectedNav3 => _selectedNav3;
  int get selectedNav4 => _selectedNav4;
}