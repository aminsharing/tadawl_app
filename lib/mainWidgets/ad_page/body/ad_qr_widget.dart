import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdQRWidget extends StatelessWidget {
  AdQRWidget({Key key, this.adsPage, this.qrData}) : super(key: key);

  final AdsProvider adsPage;
  final String qrData;

  void _launchQRLink() async {
    await adsPage.stopVideoAdsPage();
    var url = '$qrData';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        InkWell(
          onTap: _launchQRLink,
          child: QrImage(
            //plce where the QR Image will be shown
            data: qrData,
            //padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            size: 150.0,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: TextButton(
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    Share.share('$qrData');
                  },

                  child: Container(
                    height: 35.0,
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1
                      ),
                      color: Color(0xffffffff),
                    ),
                    child: Center(
                      child: Text(
                        '$qrData',
                        style: CustomTextStyle(

                          fontSize: 12,
                          color: Colors.grey,
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextButton(
                  child: Icon(
                    Icons.share,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    Share.share('$qrData');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
