import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';

void main() {
  test('Should return SearchMovieInfo object when SearchMovieInfo.fromJson is used', () {
    final testJson = File('test/domain/entities/superman_movie1.json');
    final jsonObj = json.decode(testJson.readAsStringSync());

    final searchMovieInfo = SearchMovieInfo.fromJson(jsonObj);
    expect(searchMovieInfo.adult, isFalse);
    expect(searchMovieInfo.backdropPath, equals('/zO1nXPpmJylWVHg2eL00HysZqE5.jpg'));
    expect(listEquals(searchMovieInfo.genreIds, [28, 16, 878, 10751]), isTrue);
    expect(searchMovieInfo.id, equals(13640));
    expect(searchMovieInfo.originalLanguage, equals('en'));
    expect(searchMovieInfo.originalTitle, equals('Superman: Doomsday'));
    expect(
        searchMovieInfo.overview,
        equals(
            'When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics\' publications in the 1990s.'));
    expect(searchMovieInfo.popularity, equals(118.433));
    expect(searchMovieInfo.posterPath, equals('/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg'));
    expect(searchMovieInfo.releaseDate, equals('2007-09-18'));
    expect(searchMovieInfo.title, equals('Superman: Doomsday'));
    expect(searchMovieInfo.video, isFalse);
    expect(searchMovieInfo.voteAverage, equals(6.6));
    expect(searchMovieInfo.voteCount, equals(379));
  });

  test('Should return json map when SearchMovieInfo.toJson is used', () {
    final searchMovieInfo = SearchMovieInfo(
        adult: false,
        backdropPath: '/zO1nXPpmJylWVHg2eL00HysZqE5.jpg',
        genreIds: [28, 16, 878, 10751],
        id: 13640,
        originalLanguage: 'en',
        originalTitle: 'Superman: Doomsday',
        overview:
            'When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics\' publications in the 1990s.',
        popularity: 118.433,
        posterPath: '/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg',
        releaseDate: '2007-09-18',
        title: 'Superman: Doomsday',
        video: false,
        voteAverage: 6.6,
        voteCount: 379);

    final jsonObj = searchMovieInfo.toJson();
    expect(jsonObj['adult'], isFalse);
    expect(jsonObj['backdrop_path'], equals('/zO1nXPpmJylWVHg2eL00HysZqE5.jpg'));
    expect(listEquals(jsonObj['genre_ids'].cast<int>(), [28, 16, 878, 10751]), isTrue);
    expect(jsonObj['id'], equals(13640));
    expect(jsonObj['original_language'], equals('en'));
    expect(jsonObj['original_title'], equals('Superman: Doomsday'));
    expect(
        jsonObj['overview'],
        equals(
            'When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics\' publications in the 1990s.'));
    expect(jsonObj['popularity'], equals(118.433));
    expect(jsonObj['poster_path'], equals('/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg'));
    expect(jsonObj['release_date'], equals('2007-09-18'));
    expect(jsonObj['title'], equals('Superman: Doomsday'));
    expect(jsonObj['video'], isFalse);
    expect(jsonObj['vote_average'], equals(6.6));
    expect(jsonObj['vote_count'], equals(379));
  });
}
