// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieListingStore on _MovieListingStoreBase, Store {
  Computed<bool>? _$isInitialLoadComputed;

  @override
  bool get isInitialLoad =>
      (_$isInitialLoadComputed ??= Computed<bool>(() => super.isInitialLoad,
              name: '_MovieListingStoreBase.isInitialLoad'))
          .value;
  Computed<bool>? _$isReachedLastItemComputed;

  @override
  bool get isReachedLastItem => (_$isReachedLastItemComputed ??= Computed<bool>(
          () => super.isReachedLastItem,
          name: '_MovieListingStoreBase.isReachedLastItem'))
      .value;
  Computed<bool>? _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults,
              name: '_MovieListingStoreBase.hasResults'))
          .value;

  final _$_routeStateAtom = Atom(name: '_MovieListingStoreBase._routeState');

  RouteState get routeState {
    _$_routeStateAtom.reportRead();
    return super._routeState;
  }

  @override
  set _routeState(RouteState value) {
    _$_routeStateAtom.reportWrite(value, super._routeState, () {
      super._routeState = value;
    });
  }

  final _$_searchMovieFutureAtom =
      Atom(name: '_MovieListingStoreBase._searchMovieFuture');

  ObservableFuture<SearchMovieResponse> get searchMovieFuture {
    _$_searchMovieFutureAtom.reportRead();
    return super._searchMovieFuture;
  }

  @override
  set _searchMovieFuture(ObservableFuture<SearchMovieResponse> value) {
    _$_searchMovieFutureAtom.reportWrite(value, super._searchMovieFuture, () {
      super._searchMovieFuture = value;
    });
  }

  final _$_resultsAtom = Atom(name: '_MovieListingStoreBase._results');

  ObservableList<SearchMovieInfo> get results {
    _$_resultsAtom.reportRead();
    return super._results;
  }

  @override
  set _results(ObservableList<SearchMovieInfo> value) {
    _$_resultsAtom.reportWrite(value, super._results, () {
      super._results = value;
    });
  }

  final _$_pageAtom = Atom(name: '_MovieListingStoreBase._page');

  int? get page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int? value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  final _$_totalResultsAtom =
      Atom(name: '_MovieListingStoreBase._totalResults');

  int? get totalResults {
    _$_totalResultsAtom.reportRead();
    return super._totalResults;
  }

  @override
  set _totalResults(int? value) {
    _$_totalResultsAtom.reportWrite(value, super._totalResults, () {
      super._totalResults = value;
    });
  }

  final _$_totalPagesAtom = Atom(name: '_MovieListingStoreBase._totalPages');

  int? get totalPages {
    _$_totalPagesAtom.reportRead();
    return super._totalPages;
  }

  @override
  set _totalPages(int? value) {
    _$_totalPagesAtom.reportWrite(value, super._totalPages, () {
      super._totalPages = value;
    });
  }

  final _$_generalErrorAtom =
      Atom(name: '_MovieListingStoreBase._generalError');

  String get generalError {
    _$_generalErrorAtom.reportRead();
    return super._generalError;
  }

  @override
  set _generalError(String value) {
    _$_generalErrorAtom.reportWrite(value, super._generalError, () {
      super._generalError = value;
    });
  }

  final _$getMoviesAsyncAction =
      AsyncAction('_MovieListingStoreBase.getMovies');

  @override
  Future<void> getMovies({required String query, required int pageToQuery}) {
    return _$getMoviesAsyncAction
        .run(() => super.getMovies(query: query, pageToQuery: pageToQuery));
  }

  @override
  String toString() {
    return '''
isInitialLoad: ${isInitialLoad},
isReachedLastItem: ${isReachedLastItem},
hasResults: ${hasResults}
    ''';
  }
}
