part of 'movie_listing_bloc.dart';

abstract class MovieListingEvent extends Equatable {
  const MovieListingEvent();

  @override
  List<Object> get props => [];
}

class MovieListingGetMovies extends MovieListingEvent {
  final String query;
  final int pageToQuery;

  MovieListingGetMovies({required this.query, required this.pageToQuery});

  @override
  List<Object> get props => [...super.props, query, pageToQuery];
}

class MovieListingGoToDetails extends MovieListingEvent {
  final SearchMovieInfo movieInfo;

  MovieListingGoToDetails({required this.movieInfo});

  @override
  List<Object> get props => [...super.props, movieInfo];
}

class MovieListingReturnFromDetails extends MovieListingEvent {}
