import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;



class AdvFeeProvider extends ChangeNotifier{

  AdvFeeProvider(){
    print('init AdvFeeProvider');
    initStateSelected();
  }

  @override
  void dispose() {
    print('dispose AdvFeeProvider');
    super.dispose();
    _cardNumberText.dispose();
    _cardHolderText.dispose();
    _expiryMonthText.dispose();
    _expiryYearText.dispose();
    _CVVText.dispose();
    _STCPAYText.dispose();
  }

  final List<bool> _isSelected1 = List.generate(3, (_) => false);
  int? _selectedNav1;
  final List<bool> _isSelected2 = List.generate(3, (_) => false);
  int? _selectedNav2;
  final List<bool> _isSelected3 = List.generate(2, (_) => false);
  int? _selectedNav3;
  final List<bool> _isSelected4 = List.generate(1, (_) => false);
  int? _selectedNav4;

  static const platform = MethodChannel('Hyperpay.demo.fultter/channel');

  final _cardNumberText = TextEditingController();
  TextEditingController get cardNumberText => _cardNumberText;
  final _cardHolderText = TextEditingController();
  TextEditingController get cardHolderText => _cardHolderText;
  final _expiryMonthText = TextEditingController();
  TextEditingController get expiryMonthText => _expiryMonthText;
  final _expiryYearText = TextEditingController();
  TextEditingController get expiryYearText => _expiryYearText;
  final _CVVText = TextEditingController();
  TextEditingController get CVVText => _CVVText;
  final _STCPAYText = TextEditingController();
  TextEditingController get STCPAYText => _STCPAYText;

  String _checkoutid = '';
  PaymentStatus? _resultText;
  final String _MadaRegexV = '4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)';
  final String _MadaRegexM = '5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))';

  String type = 'credit';

  String amount = '';


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

  void checkMadaCard(String cardNumber){
    // ignore: omit_local_variable_types
    String bin = cardNumber.substring(0,6);
    // ignore: omit_local_variable_types
    RegExp regExpV = RegExp(_MadaRegexV);
    // ignore: omit_local_variable_types
    RegExp regExpM = RegExp(_MadaRegexM);

    if(regExpV.hasMatch(bin) || regExpM.hasMatch(bin)){
      type = 'mada';
    }
  }

  Future<void> pay(BuildContext context) async {

    if (_cardNumberText.text.isNotEmpty &&
        _cardHolderText.text.isNotEmpty &&
        _expiryMonthText.text.isNotEmpty &&
        _expiryYearText.text.isNotEmpty &&
        _CVVText.text.isNotEmpty) {
      checkMadaCard(_cardNumberText.text);
      _checkoutid = (await _requestCheckoutId())??'';

      String transactionStatus;
      try {
        final result =
        await platform.invokeMethod('gethyperpayresponse', {
          'type': 'CustomUI',
          'checkoutid': _checkoutid,
          'mode': 'TEST',
          'brand': type,
          'card_number': _cardNumberText.text,
          'holder_name': _cardHolderText.text,
          'month': _expiryMonthText.text,
          'year': _expiryYearText.text,
          'cvv': _CVVText.text,
          'MadaRegexV': _MadaRegexV,
          'MadaRegexM': _MadaRegexM,
          'STCPAY': 'disabled'
        });
        transactionStatus = '$result';
        print("transactionStatusss: $transactionStatus");
      } on PlatformException catch (e) {
        transactionStatus = '${e.message}';
      }
      if (transactionStatus.isNotEmpty ||
          transactionStatus == 'success' ||
          transactionStatus == 'SYNC') {
        await getPaymentStatus();
      } else {
        _resultText = PaymentStatus('001', transactionStatus);
        notifyListeners();
      }
    } else {
      await Fluttertoast.showToast(msg: 'جميع الحقول مطلوبة');
    }
  }

  Future<void> getPaymentStatus() async {
    var status;
    // ignore: omit_local_variable_types
    String myUrl = 'http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutid';
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    print(status);

    var data = json.decode(response.body);

    print("payment_status: ${data["result"].toString()}");

    _resultText = PaymentStatus.fromJson(data['result']);
    notifyListeners();
  }

  Future<String?> _requestCheckoutId() async {
    var status;
    // ignore: omit_local_variable_types
    String myUrl = 'http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php';

    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      return data['id'];
    }
  }

  // Future<void> getPaymentStatus() async {
  //   var status;
  //   // ignore: omit_local_variable_types
  //   String myUrl = 'https://www.tadawl-store.com/API/api_app/payment/payment_status.php';
  //   final response = await http.post(
  //     Uri.parse(myUrl),
  //     headers: {'Accept': 'application/json'},
  //     body: {
  //       'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
  //       'id': _checkoutid
  //     }
  //   );
  //   status = response.body.contains('error');
  //
  //   var data = json.decode(response.body);
  //
  //   print("payment_status: ${data["result"].toString()}");
  //
  //   _resultText = data['result'].toString();
  // }
  //
  // Future<String?> _requestCheckoutId() async {
  //   var status;
  //   // ignore: omit_local_variable_types
  //   String myUrl = 'https://www.tadawl-store.com/API/api_app/payment/prepare_checkout.php';
  //
  //   final response = await http.post(
  //     Uri.parse(myUrl),
  //     headers: {'Accept': 'application/json'},
  //     body: {
  //       'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
  //       'amount': amount
  //     }
  //   );
  //   status = response.body.contains('error');
  //
  //   var data = json.decode(response.body);
  //
  //   if (status) {
  //     print('data : ${data["error"]}');
  //   } else {
  //     return data['id'];
  //   }
  // }


  List<bool> get isSelected1 => _isSelected1;
  List<bool> get isSelected2 => _isSelected2;
  List<bool> get isSelected3 => _isSelected3;
  List<bool> get isSelected4 => _isSelected4;
  int? get selectedNav1 => _selectedNav1;
  int? get selectedNav2 => _selectedNav2;
  int? get selectedNav3 => _selectedNav3;
  int? get selectedNav4 => _selectedNav4;
  PaymentStatus? get resultText => _resultText;
}


class PaymentStatus{
  String? code;
  String? description;
  // ignore: sort_constructors_first
  PaymentStatus(this.code, this.description);
  // ignore: sort_constructors_first
  PaymentStatus.fromJson(Map<String, dynamic> json){
    code = json['code'];
    description = json['description'];
  }

}