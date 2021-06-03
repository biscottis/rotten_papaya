import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as pathlib;
import 'package:rotten_papaya/app/config/env_config.dart';
import 'package:rotten_papaya/app/theme.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/app/utils/text_utils.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';

class MovieDetailPage extends StatefulWidget {
  static final route = '/movieDetail';

  final SearchMovieInfo? movieInfo;
  const MovieDetailPage({Key? key, this.movieInfo}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  SearchMovieInfo? movieInfo;

  @override
  void initState() {
    super.initState();

    movieInfo = widget.movieInfo ?? Get.arguments['movieInfo'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieInfo!.title!),
        backgroundColor: getColorPrimary(context),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              MovieImage(parentConstraints: constraints, movieInfo: movieInfo),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MovieDetails(movieInfo: movieInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieImage extends StatelessWidget {
  final BaseCacheManager _cacheManager;
  final BoxConstraints parentConstraints;
  final SearchMovieInfo? movieInfo;

  MovieImage({Key? key, required this.parentConstraints, required this.movieInfo})
      : _cacheManager = sl.get<BaseCacheManager>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: parentConstraints.maxWidth * 1.5,
      width: parentConstraints.maxWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: movieInfo!.id!,
            child: CachedNetworkImage(
              cacheManager: _cacheManager,
              imageUrl: _getImageUrl(movieInfo!.posterPath),
              placeholder: (context, url) => CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  String _getImageUrl(String? backdropUrl) {
    if (backdropUrl == null || backdropUrl.isEmpty) {
      return '${EnvConfig.placeholderEndpoint}/780x1170.png?text=${FlutterI18n.translate(Get.context!, 'no_image_found')}';
    }

    return '${EnvConfig.tmdbApiImageEndpoint}/w780/${pathlib.basename(backdropUrl)}';
  }
}

class MovieDetails extends StatelessWidget {
  final SearchMovieInfo? movieInfo;

  const MovieDetails({Key? key, required this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieLabelAndValue(label: FlutterI18n.translate(context, 'title'), value: movieInfo!.title),
        MovieLabelAndValue(
            label: FlutterI18n.translate(context, 'release_date'), value: _formatDate(movieInfo!.releaseDate)),
        MovieLabelAndValue(label: FlutterI18n.translate(context, 'ratings'), value: movieInfo!.voteAverage.toString()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                FlutterI18n.translate(context, 'overview'),
                style: getTextStyleSubtitle2(context),
              ),
            ),
            Text(
              movieInfo!.overview!,
              style: getTextStyleBodyText2(context),
            )
          ],
        ),
      ],
    );
  }

  String _formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return '-';
    }

    try {
      return dateFormatddMMMyyyy(FlutterI18n.currentLocale(Get.context!).toString()).format(DateTime.parse(dateTime));
    } catch (_) {
      return '-';
    }
  }
}

class MovieLabelAndValue extends StatelessWidget {
  final String label;
  final String? value;

  const MovieLabelAndValue({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 140.0,
            child: Text(
              label,
              style: getTextStyleSubtitle2(context),
            ),
          ),
          Flexible(
            child: Text(
              value!,
              style: getTextStyleBodyText2(context),
            ),
          ),
        ],
      ),
    );
  }
}
