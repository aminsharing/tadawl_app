import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class TransferFormProvider extends ChangeNotifier{
  TransferFormProvider(){
    print('init TransferFormProvider');
  }

  @override
  void dispose() {
    print('dispose TransferFormProvider');
    super.dispose();
    deleteDir();
  }

  final List<bool> _isSelected2 = List.generate(3, (_) => false);
  int? _selectedNav2;
  int _radioValue1 = -1;
  File? _imageInvoice;
  bool? _Accepted = false;
  String? _fullName, _reason, _refrencedNumber;
  final _picker3 = ImagePicker();


  void setFullName(String? fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  void updateTransferChoice(int index) {
    for (var buttonIndex3 = 0;
    buttonIndex3 < _isSelected2.length;
    buttonIndex3++) {
      if (buttonIndex3 == index) {
        _isSelected2[buttonIndex3] = true;
        _selectedNav2 = buttonIndex3;
      } else {
        _isSelected2[buttonIndex3] = false;
      }
    }

    notifyListeners();
  }

  void handleRadioValueChange1(int value) {
    _radioValue1 = value;
    notifyListeners();
  }

  void setReason(String? reason) {
    _reason = reason;
    notifyListeners();
  }

  void setRefrencedNumber(String? refrencedNumber) {
    _refrencedNumber = refrencedNumber;
    notifyListeners();
  }

  void deleteImageInvoice() {
    _imageInvoice = null;
    notifyListeners();
  }

  Future<void> deleteDir() async{
    // ignore: omit_local_variable_types
    Directory temp = await getTemporaryDirectory();
    // ignore: omit_local_variable_types
    Directory tempPath = Directory(temp.path + '/adsCache');
    if(tempPath.existsSync()){
      tempPath.deleteSync(recursive: true);
    }
  }

  Future<void> getImageInvoice() async {
    final _pickedFile3 = await _picker3.pickImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile3 != null) {
      var temp = await getTemporaryDirectory();
      var newDir = Directory(temp.path + '/adsCache');
      if(!await newDir.exists()){
        await newDir.create(recursive: true);
      }
      // ignore: omit_local_variable_types
      File? _compressedImage = await FlutterImageCompress.compressAndGetFile(
        _pickedFile3.path,
        '${newDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg',
        format: CompressFormat.jpeg,
      );
      _imageInvoice = _compressedImage;
    } else {}
    notifyListeners();
  }

  void updateAccepted(bool? Accepted) {
    _Accepted = Accepted;
    notifyListeners();
  }

  Future<void> sendTransfer(
      BuildContext context,
      String? phone,
      String? fullName,
      String? reason,
      String? refrencedNumber,
      String radioValue1,
      File? imageInvoice) async {
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (route) => false
      );
    });
  }


  List<bool> get isSelected2 => _isSelected2;
  int? get selectedNav2 => _selectedNav2;
  int get radioValue1 => _radioValue1;
  File? get imageInvoice => _imageInvoice;
  bool? get Accepted => _Accepted;
  String? get fullName => _fullName;
  String? get reason => _reason;
  String? get refrencedNumber => _refrencedNumber;


}