import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';

part 'movie_listing_event.dart';
part 'movie_listing_state.dart';

class MovieListingBloc extends Bloc<MovieListingEvent, MovieListingState> {
  final TmdbRepository _tmdbRepo;

  MovieListingBloc()
      : _tmdbRepo = sl.get<TmdbRepository>(),
        super(MovieListingInitial());

  @override
  Stream<MovieListingState> mapEventToState(
    MovieListingEvent event,
  ) async* {
    if (event is MovieListingGetMovies) {
      yield* _getMovies(event);
    } else if (event is MovieListingGoToDetails) {
      yield* _goToDetailsPage(event);
    } else if (event is MovieListingReturnFromDetails) {
      yield* _returnFromDetailsPage();
    }
  }

  Stream<MovieListingState> _getMovies(MovieListingGetMovies event) async* {
    final isFirstLoad = event.query != state.query || event.pageToQuery == 1;
    yield MovieListingLoading(
      isFirstLoad: isFirstLoad,
      query: event.query,
      movies: state.movies,
      page: event.pageToQuery,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    );

    try {
      final resp =
          await Future.delayed(Duration(seconds: 1), () => _tmdbRepo.searchMovie(event.query, page: event.pageToQuery));
      if (resp.results == null || resp.results!.isEmpty) {
        yield MovieListingNoResults(query: event.query);
        return;
      }

      yield MovieListingLoaded(
        query: event.query,
        movies: [...state.movies, ...resp.results!],
        page: resp.page ?? 0,
        totalResults: resp.totalResults ?? 0,
        totalPages: resp.totalPages ?? 0,
      );
    } on DioError catch (e) {
      if ([DioErrorType.connectTimeout, DioErrorType.receiveTimeout, DioErrorType.sendTimeout].contains(e.type)) {
        yield MovieListingGeneralError(
            generalError: 'error.timeout',
            query: event.query,
            movies: state.movies,
            page: state.page,
            totalResults: state.totalResults,
            totalPages: state.totalPages);
      } else if (DioErrorType.other == e.type && e.error is SocketException) {
        yield MovieListingGeneralError(
            generalError: 'error.no_connectivity',
            query: event.query,
            movies: state.movies,
            page: state.page,
            totalResults: state.totalResults,
            totalPages: state.totalPages);
      }
    }
  }

  Stream<MovieListingState> _goToDetailsPage(MovieListingGoToDetails event) async* {
    yield MovieDetailRedirect(
      movieInfo: event.movieInfo,
      query: state.query,
      movies: state.movies,
      page: state.page,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    );
  }

  Stream<MovieListingState> _returnFromDetailsPage() async* {
    yield MovieListingLoaded(
      query: state.query,
      movies: state.movies,
      page: state.page,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    );
  }
}
