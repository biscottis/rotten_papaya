import 'dart:io';
import 'dart:ui';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:rotten_papaya/app/constants/widget_keys.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_listing_page.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';
import 'package:rotten_papaya/domain/entities/search_movie_response.dart';

import '../../mocks/delegate_file.dart';
import '../../mocks/mocks.dart';
import '../../utils/test_app.dart';

void main() {
  testWidgets(
      'Should display grid of movies when API returns results for page 1',
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

    when(tmdbRepo.searchMovie(any, page: anyNamed('page'))).thenAnswer(
      (_) => Future.value(_mockSearchMovie()),
    );

    await tester.pumpWidget(TestApp(home: MovieListingPage()));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 1));

    expect(find.text(FlutterI18n.translate(Get.context, 'movies')),
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

  testWidgets('Should display more results when scrolled to bottom of grid',
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

    when(tmdbRepo.searchMovie(any, page: anyNamed('page'))).thenAnswer(
      (_) => Future.value(_mockSearchMovie(totalPages: 2, totalResults: 8)),
    );

    await tester.pumpWidget(TestApp(home: MovieListingPage()));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 1));

    when(tmdbRepo.searchMovie(any, page: anyNamed('page'))).thenAnswer(
      (_) => Future.value(_mockSearchMovie(
          startIndex: 3, page: 2, totalPages: 2, totalResults: 8)),
    );

    // scroll to load more data
    await tester.drag(find.byKey(WidgetKeys.movieGridKey), Offset(0.0, -800.0));
    await tester.pump(Duration(seconds: 1));

    // scroll again to bring new grid cells into view
    await tester.drag(find.byKey(WidgetKeys.movieGridKey), Offset(0.0, -800.0));
    await tester.pump();

    expect(find.text('title4'), findsOneWidget);
    expect(find.text('title5'), findsOneWidget);
    expect(find.text('title6'), findsOneWidget);

    expect(find.text('overview4'), findsOneWidget);
    expect(find.text('overview5'), findsOneWidget);
    expect(find.text('overview6'), findsOneWidget);
  });
}

SearchMovieResponse _mockSearchMovie({
  int startIndex = 0,
  int page = 1,
  int totalPages = 1,
  int totalResults = 4,
}) {
  SearchMovieInfo mockSingleResult(int index) => SearchMovieInfo(
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

  return SearchMovieResponse(
    page: page,
    totalPages: totalPages,
    totalResults: totalResults,
    results: List.generate(4, (i) => mockSingleResult(startIndex + i)),
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
