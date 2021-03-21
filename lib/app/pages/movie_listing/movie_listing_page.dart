import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:rotten_papaya/app/config/env_config.dart';
import 'package:rotten_papaya/app/stores/movie_listing_store.dart';
import 'package:rotten_papaya/app/theme.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/app/utils/text_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_easy/model/search/search_movie.dart';
import 'package:path/path.dart' as pathlib;

class MovieListingPage extends StatefulWidget {
  const MovieListingPage({Key key}) : super(key: key);

  @override
  _MovieListingPageState createState() => _MovieListingPageState();
}

class _MovieListingPageState extends State<MovieListingPage> {
  final MovieListingStore store;

  _MovieListingPageState()
      : store = sl.isRegistered<MovieListingStore>()
            ? sl.get<MovieListingStore>()
            : MovieListingStore();

  @override
  void initState() {
    super.initState();

    store.getMovies(context, query: 'superman', pageToQuery: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'rotten_papaya')),
        backgroundColor: getColorPrimary(context),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => Observer(
            builder: (_) {
              if (store.isInitialLoad) {
                return MovieGridShimmer(parentConstraints: constraints);
              }

              return MovieGrid(store: store, parentConstraints: constraints);
            },
          ),
        ),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final MovieListingStore store;
  final BoxConstraints parentConstraints;

  const MovieGrid(
      {Key key, @required this.store, @required this.parentConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: _getDesiredGridCellAspectRatio(parentConstraints),
      ),
      itemCount: store.results.length,
      itemBuilder: (_, index) {
        return MovieGridCell(movieInfo: store.results[index]);
      },
    );
  }
}

class MovieGridShimmer extends StatelessWidget {
  final BoxConstraints parentConstraints;

  const MovieGridShimmer({Key key, @required this.parentConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: _getDesiredGridCellAspectRatio(parentConstraints),
      ),
      itemCount: 4,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          child: Card(),
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
        );
      },
    );
  }
}

class MovieGridCell extends StatelessWidget {
  final SearchMovieResults movieInfo;

  const MovieGridCell({Key key, @required this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (_, constraints) => Column(
          children: [
            MovieImageWithInfo(
                movieInfo: movieInfo, parentConstraints: constraints),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  movieInfo.overview,
                  style: getTextStyleCaption(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieImageWithInfo extends StatelessWidget {
  final SearchMovieResults movieInfo;
  final BaseCacheManager _cacheManager;
  final BoxConstraints parentConstraints;

  MovieImageWithInfo(
      {@required this.movieInfo, @required this.parentConstraints})
      : _cacheManager = sl.get<BaseCacheManager>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: parentConstraints.maxWidth * 1.5,
      width: parentConstraints.maxWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            cacheManager: _cacheManager,
            imageUrl: _getImageUrl(movieInfo.backdropPath),
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
          Positioned.fill(
            child: Container(
              color: getColorOnSurface(context, opacity: opacityMin),
            ),
          ),
          Positioned(
            bottom: 16.0,
            width: 200.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      movieInfo.title,
                      textAlign: TextAlign.start,
                      style: getTextStyleBodyText1(
                        context,
                        color: Colors.white,
                        overrideFontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  _formatDate(DateTime.parse(movieInfo.releaseDate)),
                  textAlign: TextAlign.center,
                  style: getTextStyleCaption(
                    context,
                    color: Colors.white,
                    overrideFontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return dateFormatMMMyyyy(FlutterI18n.currentLocale(Get.context).toString())
        .format(dateTime);
  }

  String _getImageUrl(String backdropUrl) {
    return '${EnvConfig.tmdbApiImageEndpoint}/w500/${pathlib.basename(backdropUrl)}';
  }
}

double _getDesiredGridCellAspectRatio(BoxConstraints constraints) {
  final itemHeight = constraints.maxHeight / 2;
  final itemWidth = constraints.maxWidth / 2;

  return itemWidth / itemHeight;
}
