import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:tmdb_easy/easyTMDB.dart';

class TmdbRepository {
  final TMDB _tmdb;
  final EasyTMDB _easyTmdb;

  TmdbRepository()
      : _tmdb = sl.get<TMDB>(),
        _easyTmdb = sl.get<EasyTMDB>();

  Future<Map<dynamic, dynamic>> searchMovie(
    String query, {
    bool includeAdult = false,
    String region = 'US',
    int year,
    int primaryReleaseYear,
    String language = 'en-US',
    int page = 1,
  }) {
    return _tmdb.v3.search.queryMovies(
      query,
      includeAdult: includeAdult,
      region: region,
      year: year,
      primaryReleaseYear: primaryReleaseYear,
      language: language,
      page: page,
    );
  }

  Future<SearchMovie> searchMovie2(
    String query, {
    String language,
    bool includeAdult,
    String region,
    int year,
    int primaryReleaseYear,
    int page = 1,
  }) {
    return _easyTmdb.search().movie(
          query,
          language: language,
          includeAdult: includeAdult,
          region: region,
          year: year,
          primaryReleaseYear: primaryReleaseYear,
          page: page,
        );
  }
}
