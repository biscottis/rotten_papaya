import 'package:mobx/mobx.dart';
part 'movie_listing_store.g.dart';

class MovieListingStore = _MovieListingStoreBase with _$MovieListingStore;

abstract class _MovieListingStoreBase with Store {}
