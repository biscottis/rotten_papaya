import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_papaya/app/config/env_config.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:tmdb_easy/easyTMDB.dart';

void main() {
  test('searchMovie should return a list of superman movies', () async {
    await _registerTestDependencies();

    final repo = TmdbRepository();
    final resp = await repo.searchMovie('superman');

    expect(resp.results, isNotEmpty);
    expect(resp.totalPages > 1, isTrue);
    expect(resp.totalResults > 1, isTrue);
    expect(resp.page == 1, isTrue);
  });

  test('searchMovie2 should return a list of superman movies', () async {
    await _registerTestDependencies();

    final repo = TmdbRepository();
    final resp = await repo.searchMovie2('superman');

    expect(resp.results, isNotEmpty);
    expect(resp.totalPages > 1, isTrue);
    expect(resp.totalResults > 1, isTrue);
    expect(resp.page == 1, isTrue);
  });
}

Future<void> _registerTestDependencies() async {
  await sl.reset();

  // Actual keys and real API call, in actual tests these can be mocked
  sl.registerLazySingleton<TMDB>(
    () => TMDB(
      ApiKeys(EnvConfig.tmdbApiKeyV3, EnvConfig.tmdbApiReadKeyV4),
      logConfig: ConfigLogger.recommended(),
    ),
  );

  // Actual keys and real API call, in actual tests these can be mocked
  sl.registerLazySingleton<EasyTMDB>(() => EasyTMDB(EnvConfig.tmdbApiKeyV3));
}
