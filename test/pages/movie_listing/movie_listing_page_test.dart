import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_listing_page.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';

import '../../mocks/delegate_file.dart';
import '../../mocks/mocks.dart';
import '../../utils/test_app.dart';

void main() {
  testWidgets('Movie listing page displays list of movies',
      (WidgetTester tester) async {
    final cacheManager = MockCacheManager();
    _registerTestDependencies(cacheManager: cacheManager);

    when(cacheManager.getFileStream(any,
            key: anyNamed('key'),
            headers: anyNamed('headers'),
            withProgress: anyNamed('withProgress')))
        .thenAnswer(
      (_) => Stream.fromIterable(
        [
          FileInfo(
            DelegateFile(
                originalFile:
                    File('test/pages//movie_listing/mock_backdrop.jpg')),
            FileSource.Cache,
            DateTime.now().add(Duration(days: 1)),
            'https://image.tmdb.org/t/p/w500/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg',
          ),
        ],
      ),
    );

    await tester.pumpWidget(TestApp(home: MovieListingPage()));
    await tester.pump();
    await tester.pump();

    expect(find.text(FlutterI18n.translate(Get.context, 'rotten_papaya')),
        findsOneWidget);
    expect(find.text('Batman v Superman: Dawn of Justice'), findsWidgets);
    expect(find.text('Sep 2007'), findsWidgets);
    expect(
        find.text(
            'When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics\' publications in the 1990s.'),
        findsWidgets);
  });
}

Future<void> _registerTestDependencies({BaseCacheManager cacheManager}) async {
  await sl.reset();

  sl.registerLazySingleton<BaseCacheManager>(() => cacheManager);
}
