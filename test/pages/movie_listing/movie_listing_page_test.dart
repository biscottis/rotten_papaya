import 'dart:io';
import 'dart:ui';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_listing_page.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:tmdb_easy/easyTMDB.dart';

import '../../mocks/delegate_file.dart';
import '../../mocks/mocks.dart';
import '../../utils/test_app.dart';

void main() {
  testWidgets('Movie listing page displays list of movies',
      (WidgetTester tester) async {
    _setScreenSize(tester);

    final cacheManager = MockCacheManager();
    final tmdbRepo = MockTmdbRepository();
    await _registerTestDependencies(
        cacheManager: cacheManager, tmdbRepo: tmdbRepo);

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

    when(tmdbRepo.searchMovie2(any, page: anyNamed('page'))).thenAnswer(
      (_) => Future.value(_mockSearchMovie),
    );

    await tester.pumpWidget(TestApp(home: MovieListingPage()));
    await tester.pump();
    await tester.pump();

    expect(find.text(FlutterI18n.translate(Get.context, 'rotten_papaya')),
        findsOneWidget);
    expect(find.text('title0'), findsOneWidget);
    expect(find.text('title1'), findsOneWidget);
    expect(find.text('title2'), findsOneWidget);
    expect(find.text('title3'), findsOneWidget);

    expect(find.text('Sep 2007'), findsNWidgets(4));

    expect(find.text('overview0'), findsOneWidget);
    expect(find.text('overview1'), findsOneWidget);
    expect(find.text('overview2'), findsOneWidget);
    expect(find.text('overview3'), findsOneWidget);
  });
}

SearchMovie get _mockSearchMovie {
  SearchMovieResults mockSingleResult(int index) => SearchMovieResults(
        adult: false,
        backdropPath: '/zO1nXPpmJylWVHg2eL00HysZqE5.jpg',
        genreIds: [28, 16, 878, 10751],
        id: index,
        originalLanguage: 'en',
        originalTitle: 'originalTitle$index',
        overview: 'overview$index',
        popularity: 118.433,
        posterPath: '/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg',
        releaseDate: '2007-09-18',
        title: 'title$index',
        video: false,
        voteAverage: 6.6,
        voteCount: 379,
      );

  return SearchMovie(
    page: 1,
    totalPages: 1,
    totalResults: 4,
    results: List.generate(4, (i) => mockSingleResult(i)),
  );
}

void _setScreenSize(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(1440.0, 3040.0);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}

Future<void> _registerTestDependencies({
  BaseCacheManager cacheManager,
  TmdbRepository tmdbRepo,
}) async {
  await sl.reset();

  sl.registerLazySingleton<BaseCacheManager>(
      () => cacheManager ?? MockCacheManager());
  sl.registerLazySingleton<TmdbRepository>(
      () => tmdbRepo ?? MockTmdbRepository());
}
