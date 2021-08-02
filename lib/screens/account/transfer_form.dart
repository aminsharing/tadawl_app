import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/transfer_form_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class TransferForm extends StatelessWidget {
  TransferForm({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _transferKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<TransferFormProvider>(builder: (context, transfer, child) {

      print("TransferForm -> TransferFormProvider");

      var mediaQuery = MediaQuery.of(context);
      Provider.of<UserMutualProvider>(context, listen: false).getSession();
      var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80.0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context).transferForm,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Form(
            key: _transferKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).userInfo,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _phone),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).mobileNumber,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    style: CustomTextStyle(

                      fontSize: 10,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    keyboardType: TextInputType.number,
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).fullName,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    style: CustomTextStyle(

                      fontSize: 10,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 1,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).reqFullName;
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      transfer.setFullName(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).payType,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: mediaQuery.size.width,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ToggleButtons(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppLocalizations.of(context).memSubs,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppLocalizations.of(context).saleRentalFees,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            transfer.updateTransferChoice(index);
                          },
                          isSelected: transfer.isSelected2,
                          color: const Color(0xff8d8d8d),
                          selectedColor: const Color(0xff8d8d8d),
                          fillColor: const Color(0xffdddddd),
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 2,
                          borderColor: const Color(0xff8d8d8d),
                          selectedBorderColor: const Color(0xff8d8d8d),
                        ),
                      ),
                    ],
                  ),
                ),
                if (transfer.selectedNav2 == 0)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: const Color(0xff8d8d8d),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                activeColor: Color(0xff00cccc),
                                groupValue: transfer.radioValue1,
                                onChanged: (int value) {
                                  transfer.handleRadioValueChange1(1);
                                },
                              ),
                              Text(
                                'العضوية المميزة\n'
                                '2500 SAR',
                                style: CustomTextStyle(

                                  fontSize: 10,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Radio(
                                value: 2,
                                activeColor: Color(0xff00cccc),
                                groupValue: transfer.radioValue1,
                                onChanged: (int value) {
                                  transfer.handleRadioValueChange1(2);
                                },
                              ),
                              Text(
                                'العضوية الاحترافية\n'
                                '1900 SAR',
                                style: CustomTextStyle(

                                  fontSize: 10,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Radio(
                                value: 3,
                                activeColor: Color(0xff00cccc),
                                groupValue: transfer.radioValue1,
                                onChanged: (int value) {
                                  transfer.handleRadioValueChange1(3);
                                },
                              ),
                              Text(
                                'العضوية الأساسية\n'
                                '750 SAR',
                                style: CustomTextStyle(

                                  fontSize: 10,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                if (transfer.selectedNav2 == 1)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: const Color(0xff8d8d8d),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 4,
                                activeColor: Color(0xff00cccc),
                                groupValue: transfer.radioValue1,
                                onChanged: (int value) {
                                  transfer.handleRadioValueChange1(4);
                                },
                              ),
                              Text(
                                'رسوم التأجير\n'
                                '60 SAR',
                                style: CustomTextStyle(

                                  fontSize: 10,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Radio(
                                value: 5,
                                activeColor: Color(0xff00cccc),
                                groupValue: transfer.radioValue1,
                                onChanged: (int value) {
                                  transfer.handleRadioValueChange1(5);
                                },
                              ),
                              Text(
                                'رسوم البيع\n'
                                '475 SAR',
                                style: CustomTextStyle(

                                  fontSize: 10,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).userInfo,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).reasonTransfer,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    style: CustomTextStyle(

                      fontSize: 10,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 1,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).reqReasonTransfer;
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      transfer.setReason(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).refNumber,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    style: CustomTextStyle(

                      fontSize: 10,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    keyboardType: TextInputType.number,
                    minLines: 1,
                    maxLines: 1,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).reqRefNumber;
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      transfer.setRefrencedNumber(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).copyReceipt,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                if (transfer.imageInvoice != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: SizedBox(
                      width: mediaQuery.size.width,
                      height: 300,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: mediaQuery.size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(transfer.imageInvoice),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: TextButton(
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: Color(0xff00cccc),
                                size: 40,
                              ),
                              onPressed: () {
                                transfer.deleteImageInvoice();
                                //buildGridView();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    transfer.getImageInvoice();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Container(
                      width: mediaQuery.size.width * 0.6,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff00cccc)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).uplaodImage,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff00cccc),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Color(0xff00cccc),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CheckboxListTile(
                  activeColor: const Color(0xff00cccc),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).rule25,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  subtitle: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context).termsReturn,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: Colors.blue,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  value: transfer.Accepted,
                  onChanged: (bool value) {
                    transfer.updateAccepted(value);
                  },
                ),
                if (transfer.Accepted == true)
                  TextButton(
                    onPressed: () {
                      if (!_transferKey.currentState.validate()) {
                        return;
                      }
                      _transferKey.currentState.save();
                      transfer.sendTransfer(
                          context,
                          _phone,
                          transfer.fullName,
                          transfer.reason,
                          transfer.refrencedNumber,
                          transfer.radioValue1.toString(),
                          transfer.imageInvoice);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                      child: Container(
                        width: mediaQuery.size.width * 0.6,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff3f9d28)),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).send,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff3f9d28),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (transfer.Accepted == false)
                  TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg:
                              'من فضلك وافق على شروط الاسترجاع في تطبيق تداول العقاري',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                      child: Container(
                        width: mediaQuery.size.width * 0.6,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff989696)),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).send,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff989696),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
