import 'package:equatable/equatable.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';

class SearchMovieResponse with EquatableMixin {
  int page;
  int totalResults;
  int totalPages;
  List<SearchMovieInfo> results;

  SearchMovieResponse({this.page, this.totalResults, this.totalPages, this.results});

  SearchMovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    results = (json['results'] as List) != null
        ? (json['results'] as List).map((i) => SearchMovieInfo.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['total_results'] = totalResults;
    data['total_pages'] = totalPages;
    data['results'] = results != null ? results.map((i) => i.toJson()).toList() : null;
    return data;
  }

  @override
  List<Object> get props => [page, totalResults, totalPages, results];
}
