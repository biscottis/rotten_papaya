part of 'movie_listing_bloc.dart';

abstract class MovieListingState extends Equatable {
  final String query;
  final List<SearchMovieInfo> movies;
  final int page;
  final int totalResults;
  final int totalPages;

  const MovieListingState({
    required this.query,
    required this.movies,
    required this.page,
    required this.totalResults,
    required this.totalPages,
  });

  bool get isReachedLastPage => page == totalPages;

  @override
  List<Object> get props => [query, movies, page, totalResults, totalPages];
}

class MovieListingInitial extends MovieListingState {
  const MovieListingInitial()
      : super(query: '', movies: const <SearchMovieInfo>[], page: 0, totalResults: 0, totalPages: 0);
}

class MovieListingLoading extends MovieListingState {
  final bool isFirstLoad;

  MovieListingLoading({
    required this.isFirstLoad,
    required String query,
    required List<SearchMovieInfo> movies,
    required int page,
    required int totalResults,
    required int totalPages,
  }) : super(query: query, movies: movies, page: page, totalResults: totalResults, totalPages: totalPages);

  @override
  List<Object> get props => [isFirstLoad, ...super.props];
}

class MovieListingLoaded extends MovieListingState {
  const MovieListingLoaded({
    required String query,
    required List<SearchMovieInfo> movies,
    required int page,
    required int totalResults,
    required int totalPages,
  }) : super(query: query, movies: movies, page: page, totalResults: totalResults, totalPages: totalPages);
}

class MovieListingNoResults extends MovieListingState {
  const MovieListingNoResults({required String query})
      : super(query: query, movies: const <SearchMovieInfo>[], page: 0, totalResults: 0, totalPages: 0);
}

class MovieDetailRedirect extends MovieListingState {
  final SearchMovieInfo movieInfo;

  const MovieDetailRedirect({
    required this.movieInfo,
    required String query,
    required List<SearchMovieInfo> movies,
    required int page,
    required int totalResults,
    required int totalPages,
  }) : super(query: query, movies: movies, page: page, totalResults: totalResults, totalPages: totalPages);

  @override
  List<Object> get props => [movieInfo, ...super.props];
}

class MovieListingGeneralError extends MovieListingState {
  final String generalError;

  const MovieListingGeneralError({
    required this.generalError,
    required String query,
    required List<SearchMovieInfo> movies,
    required int page,
    required int totalResults,
    required int totalPages,
  }) : super(query: query, movies: movies, page: page, totalResults: totalResults, totalPages: totalPages);

  @override
  List<Object> get props => [generalError, ...super.props];
}
