import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:tadawl_app/provider/ads_provider/aqar_vr_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_ads_provider.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/ads_provider/today_ads_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_img_vid_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/general_provider.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/office_marker_provider.dart';
import 'package:tadawl_app/provider/region_provider.dart';
import 'package:tadawl_app/provider/user_markers_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_pass_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/login_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/provider/user_provider/offices_vr_provider.dart';
import 'package:tadawl_app/provider/user_provider/transfer_form_provider.dart';
import 'package:tadawl_app/provider/user_provider/update_my_information_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/estimateUser.dart';
import 'package:tadawl_app/screens/ads/aqar_vr.dart';
import 'package:tadawl_app/screens/ads/payment_of_fees.dart';
import 'package:tadawl_app/screens/ads/update_details.dart';
import 'package:tadawl_app/screens/ads/update_images_video.dart';
import 'package:tadawl_app/screens/ads/update_location.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:tadawl_app/mainWidgets/open_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:tadawl_app/provider/request_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

SharedPreferences localStorage;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
          ChangeNotifierProvider<CacheMarkerModel>(create: (_) => CacheMarkerModel()),
          // ChangeNotifierProvider<AdsProvider>(create: (context) => AdsProvider()),
          // ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
          ChangeNotifierProvider<RequestProvider>(create: (_) => RequestProvider()),
          ChangeNotifierProvider<RegionProvider>(create: (_) => RegionProvider()),
          ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
          ChangeNotifierProvider<GeneralProvider>(create: (_) => GeneralProvider()),

          /// a2 Ads Provider
          ChangeNotifierProvider<AdPageProvider>(create: (_) => AdPageProvider()),
          ChangeNotifierProvider<AddAdProvider>(create: (_) => AddAdProvider()),
          ChangeNotifierProvider<AdvFeeProvider>(create: (_) => AdvFeeProvider()),
          ChangeNotifierProvider<AqarVRProvider>(create: (_) => AqarVRProvider()),
          ChangeNotifierProvider<MainPageProvider>(create: (_) => MainPageProvider()),
          ChangeNotifierProvider<MenuProvider>(create: (_) => MenuProvider()),
          ChangeNotifierProvider<MutualProvider>(create: (_) => MutualProvider()),
          ChangeNotifierProvider<SearchAdsProvider>(create: (_) => SearchAdsProvider()),
          ChangeNotifierProvider<SpecialOffersProvider>(create: (_) => SpecialOffersProvider()),
          ChangeNotifierProvider<TodayAdsProvider>(create: (_) => TodayAdsProvider()),
          ChangeNotifierProvider<UpdateDetailsProvider>(create: (_) => UpdateDetailsProvider()),
          ChangeNotifierProvider<UpdateImgVedProvider>(create: (_) => UpdateImgVedProvider()),
          ChangeNotifierProvider<UpdateLocationProvider>(create: (_) => UpdateLocationProvider()),

          /// User Provider
          ChangeNotifierProvider<ChangePassProvider>(create: (_) => ChangePassProvider()),
          ChangeNotifierProvider<ChangePhoneProvider>(create: (_) => ChangePhoneProvider()),
          ChangeNotifierProvider<FavouriteProvider>(create: (_) => FavouriteProvider()),
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider<MyAccountProvider>(create: (_) => MyAccountProvider()),
          ChangeNotifierProvider<OfficesVRProvider>(create: (_) => OfficesVRProvider()),
          ChangeNotifierProvider<TransferFormProvider>(create: (_) => TransferFormProvider()),
          ChangeNotifierProvider<UpdateMyInformationProvider>(create: (_) => UpdateMyInformationProvider()),
          ChangeNotifierProvider<UserMutualProvider>(create: (_) => UserMutualProvider()),

          /// this added
          ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider()),
          ChangeNotifierProvider<OfficeMarkerProvider>(create: (_) => OfficeMarkerProvider()),
          ChangeNotifierProvider<UserMarkersProvider>(create: (_) => UserMarkersProvider()),
          ChangeNotifierProvider<MsgProvider>(create: (_) => MsgProvider()),
          ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
        ],
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            routes: {
              '/main/discussion_main': (context) => Discussion(),
              '/main/payment_of_fees': (context) => PaymentOfFees(),
              '/main/update_ads_img_ved': (context) => UpdateImgVed(),
              '/main/update_location': (context) => UpdateLocation(),
              '/main/update_datails': (context) => UpdateDetails(),
              '/main/aqar_vr': (context) => AqarVR(),
              '/main/estimate_user': (context) => Estimate(),
            },

            // when generating route applying animation
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/open_images':
                  return PageTransition(
                    child: OpenImages(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/discussion_main':
                  return PageTransition(
                    child: Discussion(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/payment_of_fees':
                  return PageTransition(
                    child: PaymentOfFees(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/update_ads_img_ved':
                  return PageTransition(
                    child: UpdateImgVed(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/update_location':
                  return PageTransition(
                    child: UpdateLocation(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/update_datails':
                  return PageTransition(
                    child: UpdateDetails(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/aqar_vr':
                  return PageTransition(
                    child: AqarVR(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                case '/estimate_user':
                  return PageTransition(
                    child: Estimate(),
                    type: PageTransitionType.bottomToTop,
                    settings: settings,
                    reverseDuration: Duration(milliseconds: 10),
                  );
                  break;
                default:
                  return null;
              }
            },
            // ignore: missing_return
            localeListResolutionCallback: (locales, supportedLocales) {
              for (var i = 0; i < locales.length; i++) {
                if (provider.locale == null) {
                  return Locale('ar', 'SA');
                }
              }
            },
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Tadawl App',
            home: Home(),
          );
        },
      );
}
