import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';

part 'movie_listing_state.dart';

class MovieListingCubit extends Cubit<MovieListingState> {
  final TmdbRepository _tmdbRepo;

  MovieListingCubit()
      : _tmdbRepo = sl.get<TmdbRepository>(),
        super(MovieListingInitial());

  Future<void> getMovies({
    required String query,
    required int pageToQuery,
  }) async {
    final isFirstLoad = query != state.query || pageToQuery == 1;
    emit(MovieListingLoading(
      isFirstLoad: isFirstLoad,
      query: query,
      movies: state.movies,
      page: pageToQuery,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    ));

    try {
      final resp = await Future.delayed(Duration(seconds: 1), () => _tmdbRepo.searchMovie(query, page: pageToQuery));
      if (resp.results == null || resp.results!.isEmpty) {
        emit(MovieListingNoResults(query: query));
        return;
      }

      emit(MovieListingLoaded(
        query: query,
        movies: [...state.movies, ...resp.results!],
        page: resp.page ?? 0,
        totalResults: resp.totalResults ?? 0,
        totalPages: resp.totalPages ?? 0,
      ));
    } on DioError catch (e) {
      if ([DioErrorType.connectTimeout, DioErrorType.receiveTimeout, DioErrorType.sendTimeout].contains(e.type)) {
        emit(MovieListingGeneralError(
            generalError: 'error.timeout',
            query: query,
            movies: state.movies,
            page: state.page,
            totalResults: state.totalResults,
            totalPages: state.totalPages));
      } else if (DioErrorType.other == e.type && e.error is SocketException) {
        emit(MovieListingGeneralError(
            generalError: 'error.no_connectivity',
            query: query,
            movies: state.movies,
            page: state.page,
            totalResults: state.totalResults,
            totalPages: state.totalPages));
      }
    }
  }

  void goToDetailsPage(SearchMovieInfo movieInfo) {
    emit(MovieDetailRedirect(
      movieInfo: movieInfo,
      query: state.query,
      movies: state.movies,
      page: state.page,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    ));
  }

  void returnFromDetailsPage() {
    emit(MovieListingLoaded(
      query: state.query,
      movies: state.movies,
      page: state.page,
      totalResults: state.totalResults,
      totalPages: state.totalPages,
    ));
  }
}
