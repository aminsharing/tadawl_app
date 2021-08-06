import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/fee_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';

class SelectedNav2 extends StatelessWidget {
  const SelectedNav2({Key key, @required this.advFeeProvider}) : super(key: key);
  final AdvFeeProvider advFeeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffffffff),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FeeCard(
              selectedNav: [],
              price: '250',
              type: 'العقد التجاري',
              cardType: CardType.small,
              title: AppLocalizations
                  .of(context)
                  .commercialContract,
            advFeeProvider: advFeeProvider,
          ),
          FeeCard(selectedNav: [],
              price: '200',
              type: 'العقد السكني',
              cardType: CardType.small,
              title: AppLocalizations
                  .of(context)
                  .housingContract,
            advFeeProvider: advFeeProvider,
          ),
        ],
      ),
    );
  }
}
