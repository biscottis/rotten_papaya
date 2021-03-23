import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';

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
}

Future<void> _registerTestDependencies() async {
  await sl.reset();

  sl.registerLazySingleton<Dio>(() => Dio());
}
