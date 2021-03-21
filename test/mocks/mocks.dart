import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:rotten_papaya/data/repositories/tmdb_repository.dart';

// Repositories
class MockTmdbRepository extends Mock implements TmdbRepository {}

// Misc
class MockCacheManager extends Mock implements BaseCacheManager {}
