import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:rotten_papaya/app/pages/counter_page.dart';
import 'package:rotten_papaya/app/theme.dart';

class RottenPapayaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            fallbackFile: 'en_GB',
            basePath: 'assets/i18n',
            useCountryCode: true,
            forcedLocale: Locale('en', 'GB'),
            decodeStrategies: [JsonDecodeStrategy()],
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => CounterPage(title: 'Flutter Demo Home Page'),
        ),
      ],
    );
  }
}
