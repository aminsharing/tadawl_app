import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
          ChangeNotifierProvider<CacheMarkerModel>(create: (_) => CacheMarkerModel()),
          ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
          // ChangeNotifierProvider<MutualProvider>(create: (_) => MutualProvider()),
        ],
        builder: (context, child) {
          // FirebaseCrashlytics.instance.crash();
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