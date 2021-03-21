// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieListingStore on _MovieListingStoreBase, Store {
  Computed<bool> _$isInitialLoadComputed;

  @override
  bool get isInitialLoad =>
      (_$isInitialLoadComputed ??= Computed<bool>(() => super.isInitialLoad,
              name: '_MovieListingStoreBase.isInitialLoad'))
          .value;
  Computed<bool> _$isReachedLastItemComputed;

  @override
  bool get isReachedLastItem => (_$isReachedLastItemComputed ??= Computed<bool>(
          () => super.isReachedLastItem,
          name: '_MovieListingStoreBase.isReachedLastItem'))
      .value;

  final _$_searchMovieFutureAtom =
      Atom(name: '_MovieListingStoreBase._searchMovieFuture');

  @override
  ObservableFuture<SearchMovieResponse> get _searchMovieFuture {
    _$_searchMovieFutureAtom.reportRead();
    return super._searchMovieFuture;
  }

  @override
  set _searchMovieFuture(ObservableFuture<SearchMovieResponse> value) {
    _$_searchMovieFutureAtom.reportWrite(value, super._searchMovieFuture, () {
      super._searchMovieFuture = value;
    });
  }

  final _$resultsAtom = Atom(name: '_MovieListingStoreBase.results');

  @override
  ObservableList<SearchMovieInfo> get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(ObservableList<SearchMovieInfo> value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  final _$pageAtom = Atom(name: '_MovieListingStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$totalResultsAtom = Atom(name: '_MovieListingStoreBase.totalResults');

  @override
  int get totalResults {
    _$totalResultsAtom.reportRead();
    return super.totalResults;
  }

  @override
  set totalResults(int value) {
    _$totalResultsAtom.reportWrite(value, super.totalResults, () {
      super.totalResults = value;
    });
  }

  final _$totalPagesAtom = Atom(name: '_MovieListingStoreBase.totalPages');

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  final _$getMoviesAsyncAction =
      AsyncAction('_MovieListingStoreBase.getMovies');

  @override
  Future<void> getMovies(BuildContext context,
      {@required String query, @required int pageToQuery}) {
    return _$getMoviesAsyncAction.run(
        () => super.getMovies(context, query: query, pageToQuery: pageToQuery));
  }

  @override
  String toString() {
    return '''
results: ${results},
page: ${page},
totalResults: ${totalResults},
totalPages: ${totalPages},
isInitialLoad: ${isInitialLoad},
isReachedLastItem: ${isReachedLastItem}
    ''';
  }
}
