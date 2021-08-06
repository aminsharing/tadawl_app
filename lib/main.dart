import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';

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
          // ChangeNotifierProvider<RequestProvider>(create: (_) => RequestProvider()),
          // ChangeNotifierProvider<RegionProvider>(create: (_) => RegionProvider()),
          ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
          // ChangeNotifierProvider<GeneralProvider>(create: (_) => GeneralProvider()),

          /// a2 Ads Provider
          // ChangeNotifierProvider<AdPageProvider>(create: (_) => AdPageProvider()),
          // ChangeNotifierProvider<AddAdProvider>(create: (_) => AddAdProvider()),
          // ChangeNotifierProvider<AdvFeeProvider>(create: (_) => AdvFeeProvider()),
          // ChangeNotifierProvider<AqarVRProvider>(create: (_) => AqarVRProvider()),
          // ChangeNotifierProvider<MainPageProvider>(create: (_) => MainPageProvider()),
          // ChangeNotifierProvider<MenuProvider>(create: (_) => MenuProvider()),
          ChangeNotifierProvider<MutualProvider>(create: (_) => MutualProvider()),
          // ChangeNotifierProvider<SearchAdsProvider>(create: (_) => SearchAdsProvider()),
          // ChangeNotifierProvider<SpecialOffersProvider>(create: (_) => SpecialOffersProvider()),
          // ChangeNotifierProvider<TodayAdsProvider>(create: (_) => TodayAdsProvider()),
          // ChangeNotifierProvider<UpdateDetailsProvider>(create: (_) => UpdateDetailsProvider()),
          // ChangeNotifierProvider<UpdateImgVedProvider>(create: (_) => UpdateImgVedProvider()),
          // ChangeNotifierProvider<UpdateLocationProvider>(create: (_) => UpdateLocationProvider()),

          /// User Provider
          // ChangeNotifierProvider<ChangePassProvider>(create: (_) => ChangePassProvider()),
          // ChangeNotifierProvider<ChangePhoneProvider>(create: (_) => ChangePhoneProvider()),
          // ChangeNotifierProvider<FavouriteProvider>(create: (_) => FavouriteProvider()),
          // ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          // ChangeNotifierProvider<MyAccountProvider>(create: (_) => MyAccountProvider()),
          // ChangeNotifierProvider<OfficesVRProvider>(create: (_) => OfficesVRProvider()),
          // ChangeNotifierProvider<TransferFormProvider>(create: (_) => TransferFormProvider()),
          // ChangeNotifierProvider<UserMutualProvider>(create: (_) => UserMutualProvider()),

          /// this added
          // ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider()),
          // ChangeNotifierProvider<OfficeMarkerProvider>(create: (_) => OfficeMarkerProvider()),
          // ChangeNotifierProvider<UserMarkersProvider>(create: (_) => UserMarkersProvider()),
          ChangeNotifierProvider<MsgProvider>(create: (_) => MsgProvider()),
          ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
        ],
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
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