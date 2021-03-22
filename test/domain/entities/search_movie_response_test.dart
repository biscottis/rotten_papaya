import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';
import 'package:rotten_papaya/domain/entities/search_movie_response.dart';

void main() {
  test('Should return SearchMovieResponse object when SearchMovieResponse.fromJson is used', () {
    final testJson = File('test/domain/entities/superman_page1.json');
    final jsonObj = json.decode(testJson.readAsStringSync());

    final searchMovieResp = SearchMovieResponse.fromJson(jsonObj);
    expect(searchMovieResp.page, equals(1));
    expect(searchMovieResp.totalPages, equals(8));
    expect(searchMovieResp.totalResults, equals(154));
    expect(searchMovieResp.results.length, equals(20));
  });

  test('Should return json map when SearchMovieResponse.toJson is used', () {
    final searchMovieResp = SearchMovieResponse(
      page: 1,
      results: [SearchMovieInfo(), SearchMovieInfo()],
      totalPages: 9,
      totalResults: 377,
    );

    final jsonObj = searchMovieResp.toJson();
    expect(jsonObj['page'], equals(1));
    expect(jsonObj['total_pages'], equals(9));
    expect(jsonObj['total_results'], equals(377));
    expect(jsonObj['results'].length, equals(2));
  });
}
