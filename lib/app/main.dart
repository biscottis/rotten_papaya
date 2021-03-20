import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:rotten_papaya/app/rotten_papaya_app.dart';
import 'package:rotten_papaya/app/utils/env_utils.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );

      runApp(RottenPapayaApp());
    },
    (error, stack) => _handleUncaughtError(error, stack),
  );
}

void _handleUncaughtError(Object error, StackTrace stack) {
  var contentText = FlutterI18n.translate(Get.context, 'something_went_wrong');
  if (isDebugMode()) {
    contentText += '\n\nDEBUG: ${error.toString()}';
  }

  Get.dialog(
    AlertDialog(
      title: Text(FlutterI18n.translate(Get.context, 'oops')),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            FlutterI18n.translate(Get.context, 'ok'),
          ),
        )
      ],
    ),
  );
}
