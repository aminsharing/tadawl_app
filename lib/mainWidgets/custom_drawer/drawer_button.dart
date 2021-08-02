import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.page
  }) : super(key: key);
  final IconData icon;
  final String text;
  final page;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if(icon == Icons.library_books_rounded){
        }else if(icon == Icons.business_rounded){
          Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
        }
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 10),
              child: page),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 120,
          height: 78,
          color: Color(0xff00cccc),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: Icon(icon,
                    color: Color(0xffffffff),
                    size: 30,
                  ),
                ),
              ),
              Text(
                text,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}