import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_detail_page.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';
import 'package:rotten_papaya/domain/entities/search_movie_response.dart';

part 'movie_listing_store.g.dart';

class MovieListingStore = _MovieListingStoreBase with _$MovieListingStore;

abstract class _MovieListingStoreBase with Store {
  final TmdbRepository _tmdbRepo;

  @observable
  ObservableFuture<SearchMovieResponse> _searchMovieFuture;

  @computed
  bool get isInitialLoad => (_searchMovieFuture.status == FutureStatus.pending && _isFirstLoad);

  @readonly
  @observable
  // ignore: prefer_final_fields
  ObservableList<SearchMovieInfo> _results;

  @readonly
  @observable
  int? _page;

  @readonly
  @observable
  int? _totalResults;

  @readonly
  @observable
  int? _totalPages;

  @computed
  bool get isReachedLastItem => _page == _totalPages;

  String _currentQuery;
  bool _isFirstLoad;

  ScrollController movieGridScrollController;

  @computed
  bool get hasResults => !isInitialLoad && _results.isNotEmpty;

  _MovieListingStoreBase()
      : _tmdbRepo = sl.get<TmdbRepository>(),
        _searchMovieFuture = Future.value(SearchMovieResponse()).asObservable(),
        _results = <SearchMovieInfo>[].asObservable(),
        _page = 0,
        _totalResults = 0,
        _totalPages = 0,
        _currentQuery = '',
        _isFirstLoad = false,
        movieGridScrollController = ScrollController();

  void configureMovieGridScrollListener(BuildContext context, {required String query}) {
    movieGridScrollController.addListener(() {
      final currentPosition = movieGridScrollController.position.pixels;
      final maxPosition = movieGridScrollController.position.maxScrollExtent;

      if (currentPosition >= (maxPosition * 0.85)) {
        if (!isReachedLastItem && _searchMovieFuture.status != FutureStatus.pending) {
          getMovies(context, query: query, pageToQuery: _page! + 1);
        }
      }
    });
  }

  @action
  Future<void> getMovies(
    BuildContext context, {
    required String query,
    required int pageToQuery,
  }) async {
    _isFirstLoad = _currentQuery != query || pageToQuery == 1;
    if (_isFirstLoad) {
      _results.clear();
      _currentQuery = query;
    }

    try {
      _searchMovieFuture =
          Future.delayed(Duration(seconds: 1), () => _tmdbRepo.searchMovie(_currentQuery, page: pageToQuery))
              .asObservable();
      // _searchMovieFuture = _tmdbRepo
      //     .searchMovie(_currentQuery, page: pageToQuery)
      //     .asObservable();
      final resp = await _searchMovieFuture;

      _results.addAll(resp.results!);
      _page = resp.page;
      _totalResults = resp.totalResults;
      _totalPages = resp.totalPages;
    } on DioError catch (e) {
      if ([DioErrorType.connectTimeout, DioErrorType.receiveTimeout, DioErrorType.sendTimeout].contains(e.type)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, 'error.timeout'))));
      } else if (DioErrorType.other == e.type && e.error is SocketException) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, 'error.no_connectivity'))));
      }
    }
  }

  void goToDetailsPage(SearchMovieInfo movieInfo) {
    Get.toNamed(MovieDetailPage.route, arguments: {
      'movieInfo': movieInfo,
    });
  }
}
