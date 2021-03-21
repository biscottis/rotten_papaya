import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:rotten_papaya/app/theme.dart';

class MovieListingPage extends StatefulWidget {
  @override
  _MovieListingPageState createState() => _MovieListingPageState();
}

class _MovieListingPageState extends State<MovieListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'rotten_papaya')),
        backgroundColor: getColorPrimary(context),
      ),
      body: Center(
        child: Text(FlutterI18n.translate(context, 'rotten_papaya')),
      ),
    );
  }
}
