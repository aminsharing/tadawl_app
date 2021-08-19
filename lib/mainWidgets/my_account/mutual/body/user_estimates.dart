import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/UserEstimateModel.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/estimateUser.dart';

class UserEstimates extends StatelessWidget {
  const UserEstimates({
    Key key,
    @required this.estimates,
    @required this.sumEstimates,
    @required this.myAccountProvider,
  }) : super(key: key);
  final List<UserEstimateModel> estimates;
  final UserEstimateModel sumEstimates;
  final MyAccountProvider myAccountProvider;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider<MyAccountProvider>.value(
              value: myAccountProvider,
              child: Estimate(myAccountProvider: myAccountProvider,),
            )
            ));
      },
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.fromLTRB(
                0, 0, 15, 0),
            child: Text(
              estimates.isNotEmpty
                  ?
              '(${estimates.length})'
                  :
              '(0)',
              style: CustomTextStyle(
                fontSize: 10,
                color:
                const Color(0xff989696),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.fromLTRB(
                0, 0, 0, 0),
            child: RatingBar(
              rating: sumEstimates != null
                  ?
              (double.parse(sumEstimates.sum_estimates ?? '0') / estimates.length).toDouble()
                  : 3,
              icon: Icon(
                Icons.star,
                size: 15,
                color: Colors.grey,
              ),
              starCount: 5,
              spacing: 1.0,
              size: 15,
              isIndicator: true,
              allowHalfRating: true,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
