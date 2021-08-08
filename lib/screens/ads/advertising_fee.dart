import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/selected_nav0.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/selected_nav1.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/selected_nav2.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdvertisingFee extends StatelessWidget {
  AdvertisingFee({
    Key key,
  }) : super(key: key);

  final AdvFeeProvider advFeeProvider = AdvFeeProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdvFeeProvider>(
      create: (_) => advFeeProvider,
      child: Consumer<AdvFeeProvider>(builder: (context, advFee, child) {


        return WillPopScope(
          onWillPop: () async{
            advFee.updateSelected1(0);
            advFee.updateSelected2(0);
            advFee.updateSelected3(0);
            return true;
          },
          child: Scaffold(
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
                AppLocalizations.of(context).advFees,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text(
                                AppLocalizations.of(context).officesMarketers,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                ).getTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text(
                                AppLocalizations.of(context).owner,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                ).getTextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text(
                                AppLocalizations.of(context).leaseContracts,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                ).getTextStyle(),
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            advFee.updateSelected1(index);
                          },
                          isSelected: advFee.isSelected1,
                          color: const Color(0xff8d8d8d),
                          selectedColor: const Color(0xffffffff),
                          fillColor: const Color(0xff3f9d28),
                          borderRadius: BorderRadius.circular(0),
                          borderWidth: 1,
                          borderColor: const Color(0xffdddddd),
                          selectedBorderColor: const Color(0xffdddddd),
                        ),
                      ],
                    ),
                  ),
                  if (advFee.selectedNav1 == 0)
                    SelectedNav0(advFeeProvider: advFeeProvider,),
                  if (advFee.selectedNav1 == 1)
                    SelectedNav1(advFeeProvider: advFeeProvider,),
                  if (advFee.selectedNav1 == 2)
                    SelectedNav2(advFeeProvider: advFeeProvider,),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
