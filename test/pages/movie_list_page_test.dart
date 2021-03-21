import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rotten_papaya/app/pages/movie_listing_page.dart';

import '../utils/test_app.dart';

void main() {
  testWidgets('Movie listing page display list of movies',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(home: MovieListingPage()));
    await tester.pumpAndSettle();

    expect(find.text(FlutterI18n.translate(Get.context, 'rotten_papaya')),
        findsNWidgets(2));
  });
}
