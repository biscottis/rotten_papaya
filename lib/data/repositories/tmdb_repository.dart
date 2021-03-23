import 'package:dio/dio.dart';
import 'package:rotten_papaya/app/config/env_config.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/domain/entities/search_movie_response.dart';

class TmdbRepository {
  final Dio _dio;

  TmdbRepository() : _dio = sl.get<Dio>();

  Future<SearchMovieResponse> searchMovie(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
    String region,
    int year,
    int primaryReleaseYear,
  }) async {
    final resp = await _dio.get('${EnvConfig.tmdbApiEndpoint}/search/movie', queryParameters: {
      'api_key': EnvConfig.tmdbApiKeyV3,
      'query': query,
      'page': page,
      'include_adult': includeAdult,
      'language': language,
      if (region != null) 'region': region,
      if (year != null) 'year': year,
      if (primaryReleaseYear != null) 'primary_release_year': primaryReleaseYear,
    });

    return SearchMovieResponse.fromJson(resp.data);
  }
}
