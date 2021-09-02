import 'package:flutter/cupertino.dart';

class AdPageHelperProvider extends ChangeNotifier{
  PageController _adController = PageController();


  @override
  void dispose() {
    _adController.dispose();
    super.dispose();
  }


  PageController setControllerIndex(int currentIndex){
    _adController = PageController(initialPage: currentIndex);
    return _adController;
  }

  void nextIndex(){
    _adController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void previousIndex(){
    _adController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }



  PageController get adController => _adController;
}