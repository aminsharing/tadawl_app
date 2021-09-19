import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdQRWidget extends StatelessWidget {
  AdQRWidget({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    
    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      void _launchQRLink() async {
        adsPage.stopVideoAdsPage();
        var url = '${adsPage.qrData}';
        await launch(url);
        // if (await canLaunch(url)) {
        //   await launch(url);
        // } else {
        //   throw 'Could not launch $url';
        // }
      }
      return Column(
        children: [
          SizedBox(
            height: 40.0,
          ),
          InkWell(
            onTap: _launchQRLink,
            child: QrImage(
              //place where the QR Image will be shown
              data: adsPage.qrData,
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
                      if(!adsPage.isSharing){
                        Fluttertoast.showToast(msg: 'جار تحضير الإعلان للمشاركة...');
                        adsPage.isSharing = true;
                        adsPage.stopVideoAdsPage();
                        adsPage.downloadImageForShare('https://tadawl-store.com/API/assets/images/ads/${adsPage.adsPageImages.first.ads_image}').then((value) {
                          Share.shareFiles([value.path], text: '${adsPage.qrData}').then((value) {
                            adsPage.isSharing = false;
                          });
                        });
                      }
                      // adsPage.stopVideoAdsPage();
                      // Share.share('${adsPage.qrData}');
                    },

                    child: Container(
                      height: 35.0,
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        border: Border.all(
                            color: adsPage.isSharing ? Colors.grey.shade300 : Colors.grey,
                            width: 1
                        ),
                        color: Color(0xffffffff),
                      ),
                      child: Center(
                        child: Text(
                          '${adsPage.qrData.split('/')[2]}/${adsPage.qrData.split('/')[3]}',
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
                    onPressed: () {
                      if(!adsPage.isSharing){
                        Fluttertoast.showToast(msg: 'جار تحضير الإعلان للمشاركة...');
                        adsPage.isSharing = true;
                        adsPage.stopVideoAdsPage();
                        adsPage.downloadImageForShare('https://tadawl-store.com/API/assets/images/ads/${adsPage.adsPageImages.first.ads_image}').then((value) {
                          Share.shareFiles([value.path], text: '${adsPage.qrData}').then((value) {
                            adsPage.isSharing = false;
                          });
                        });
                      }
                      // Share.share('${adsPage.qrData}');
                    },
                    child: Icon(
                      Icons.share,
                      color: adsPage.isSharing ? Colors.grey.shade300 : Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
