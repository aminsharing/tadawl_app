import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/update_details/stage_1.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Stage0 extends StatelessWidget {
  const Stage0(this._id_description ,{Key key}) : super(key: key);
  final String _id_description;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: const Color(0xff00cccc),
        leadingWidth: 70,
        title: Text(
          AppLocalizations.of(context)
              .chooseCategory,
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            Provider.of<MutualProvider>(context, listen: false)
                .getAllAdsPageInfo(context, _id_description);

            Future.delayed(Duration(seconds: 1),
                    () {
              Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           AdPage()),
                  // );
                });
          },
        ),
      ), // updateDetails.categoryUpdate.length
      body:
      Provider.of<AdPageProvider>(context, listen: true)
          .adsUpdateDetails.isNotEmpty
            ?
      Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, _){
        print("Stage0 -> UpdateDetailsProvider");
        final mutualProv = Provider.of<MutualProvider>(context, listen: false);
        updateDetails.getAdsUpdateInfo(mutualProv.adsBF, mutualProv.adsQF, mutualProv.adsPage.first.idInterface, mutualProv.adsPage.first.idTypeAqar, mutualProv.adsPage.first.idTypeRes);
        if(updateDetails.categoryUpdate.isNotEmpty){
          return ListView.builder(
            itemCount: updateDetails.categoryUpdate.length,
            itemBuilder: (context, i){
              if (Provider.of<AdPageProvider>(context, listen: false).adsUpdateDetails.first.idCategory == updateDetails.categoryUpdate[i].id_category) {
                return TextButton(
                  onPressed: () {
                    updateDetails.updateCategoryDetails(
                        int.parse(updateDetails
                            .categoryUpdate[i].id_category),
                        updateDetails
                            .categoryUpdate[i].name);
                    // updateDetails
                    //     .setCurrentStageUpdateDetails(1);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Stage1(_id_description)));
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xff00cccc),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _lang != 'en_US'
                                ? updateDetails
                                .categoryUpdate[i].name
                                : updateDetails
                                .categoryUpdate[i]
                                .en_name,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color:
                              const Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffffffff),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else {
                return TextButton(
                  onPressed: () {
                    updateDetails.updateCategoryDetails(
                        int.parse(updateDetails
                            .categoryUpdate[i].id_category),
                        updateDetails
                            .categoryUpdate[i].name);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Stage1(_id_description)));
                    // updateDetails.setCurrentStageUpdateDetails(1);
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _lang != 'en_US'
                                ? updateDetails
                                .categoryUpdate[i].name
                                : updateDetails
                                .categoryUpdate[i]
                                .en_name,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff00cccc),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff00cccc),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }

      },)
            :
      Container(),
    );
  }
}
