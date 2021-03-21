import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mobx/mobx.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:tmdb_easy/model/search/search_movie.dart';

part 'movie_listing_store.g.dart';

class MovieListingStore = _MovieListingStoreBase with _$MovieListingStore;

abstract class _MovieListingStoreBase with Store {
  final TmdbRepository _tmdbRepo;

  @observable
  ObservableFuture<SearchMovie> _searchMovieFuture;

  @computed
  bool get isInitialLoad =>
      (_searchMovieFuture.status == FutureStatus.pending && _isFirstLoad);

  @observable
  ObservableList<SearchMovieResults> results;

  @observable
  int page;

  @observable
  int totalResults;

  @observable
  int totalPages;

  @computed
  bool get isReachedLastItem => page == totalPages;

  String _currentQuery;
  bool _isFirstLoad;

  ScrollController movieGridScrollController;

  _MovieListingStoreBase()
      : _tmdbRepo = sl.get<TmdbRepository>(),
        _searchMovieFuture = Future.value(SearchMovie()).asObservable(),
        results = <SearchMovieResults>[].asObservable(),
        page = 0,
        totalResults = 0,
        totalPages = 0,
        _currentQuery = '',
        _isFirstLoad = false,
        movieGridScrollController = ScrollController();

  void configureMovieGridScrollListener(BuildContext context,
      {@required String query}) {
    movieGridScrollController.addListener(() {
      final currentPosition = movieGridScrollController.position.pixels;
      final maxPosition = movieGridScrollController.position.maxScrollExtent;

      if (currentPosition >= (maxPosition * 0.85)) {
        if (!isReachedLastItem &&
            _searchMovieFuture.status != FutureStatus.pending) {
          getMovies(context, query: query, pageToQuery: page + 1);
        }
      }
    });
  }

  @action
  Future<void> getMovies(
    BuildContext context, {
    @required String query,
    @required int pageToQuery,
  }) async {
    _isFirstLoad = _currentQuery != query || pageToQuery == 1;
    if (_isFirstLoad) {
      results.clear();
      _currentQuery = query;
    }

    try {
      _searchMovieFuture = Future.delayed(Duration(seconds: 1),
              () => _tmdbRepo.searchMovie2(_currentQuery, page: pageToQuery))
          .asObservable();
      // _searchMovieFuture = _tmdbRepo
      //     .searchMovie2(_currentQuery, page: pageToQuery)
      //     .asObservable();
      final resp = await _searchMovieFuture;

      results.addAll(resp.results);
      page = resp.page;
      totalResults = resp.totalResults;
      totalPages = resp.totalPages;
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(FlutterI18n.translate(context, 'error.timeout'))));
    } on Exception catch (e) {
      if (e.toString() == 'Exception: No Internet connection') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(FlutterI18n.translate(context, 'error.no_connectivity'))));
        return;
      }

      rethrow;
    }
  }
}
