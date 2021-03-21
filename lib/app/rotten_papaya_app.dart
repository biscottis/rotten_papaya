import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_detail_page.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_listing_page.dart';
import 'package:rotten_papaya/app/theme.dart';

class RottenPapayaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rotten Papaya',
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
      initialRoute: MovieListingPage.route,
      getPages: pageRoutes,
    );
  }
}

final List<GetPage> pageRoutes = [
  GetPage(
    name: MovieListingPage.route,
    page: () => MovieListingPage(),
  ),
  GetPage(
    name: MovieDetailPage.route,
    page: () => MovieDetailPage(),
  ),
];
