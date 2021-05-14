import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as pathlib;
import 'package:rotten_papaya/app/config/env_config.dart';
import 'package:rotten_papaya/app/constants/widget_keys.dart';
import 'package:rotten_papaya/app/cubits/movie_listing_cubit.dart';
import 'package:rotten_papaya/app/pages/movie_listing/movie_detail_page.dart';
import 'package:rotten_papaya/app/theme.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/app/utils/text_utils.dart';
import 'package:rotten_papaya/domain/entities/search_movie_info.dart';
import 'package:shimmer/shimmer.dart';

const _portraitGridCellCount = 2;
const _landscapeGridCellCount = 4;

class MovieListingCubitPage extends StatefulWidget {
  static final route = '/';

  const MovieListingCubitPage({Key? key}) : super(key: key);

  @override
  _MovieListingCubitPageState createState() => _MovieListingCubitPageState();
}

class _MovieListingCubitPageState extends State<MovieListingCubitPage> {
  final MovieListingCubit cubit;
  final ScrollController movieGridScrollController;

  _MovieListingCubitPageState()
      : cubit = MovieListingCubit(),
        movieGridScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    configureMovieGridScrollListener();
    cubit.getMovies(query: 'superman', pageToQuery: 1);
  }

  void configureMovieGridScrollListener() {
    movieGridScrollController.addListener(() {
      final currentPosition = movieGridScrollController.position.pixels;
      final maxPosition = movieGridScrollController.position.maxScrollExtent;

      if (currentPosition >= (maxPosition * 0.85)) {
        if (!cubit.state.isReachedLastPage && cubit.state is! MovieListingLoading) {
          cubit.getMovies(query: cubit.state.query, pageToQuery: cubit.state.page + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<MovieListingCubit, MovieListingState>(
        listener: (context, state) async {
          if (state is MovieDetailRedirect) {
            await Get.toNamed(MovieDetailPage.route, arguments: {'movieInfo': state.movieInfo});
            cubit.returnFromDetailsPage();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(FlutterI18n.translate(context, 'movies')),
              backgroundColor: getColorPrimary(context),
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  if (state is MovieListingLoading && state.isFirstLoad) {
                    return MovieGridShimmer(parentConstraints: constraints);
                  }

                  if (state is MovieListingNoResults) {
                    return Center(child: Text(FlutterI18n.translate(context, 'no_results_found')));
                  }

                  return MovieGrid(
                    parentConstraints: constraints,
                    movieGridScrollController: movieGridScrollController,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final BoxConstraints parentConstraints;
  final ScrollController movieGridScrollController;

  const MovieGrid({Key? key, required this.parentConstraints, required this.movieGridScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListingCubit, MovieListingState>(
      builder: (context, state) {
        return GridView.builder(
          key: WidgetKeys.movieGridKey,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                Get.mediaQuery.orientation == Orientation.portrait ? _portraitGridCellCount : _landscapeGridCellCount,
            childAspectRatio: _getDesiredGridCellAspectRatio(parentConstraints, Get.mediaQuery.orientation),
          ),
          controller: movieGridScrollController,
          itemCount: state.movies.length + 1,
          itemBuilder: (_, index) {
            if (index == state.movies.length) {
              if (!state.isReachedLastPage) {
                return MovieCardShimmer();
              }

              return SizedBox.shrink();
            }

            return MovieGridCell(movieInfo: state.movies[index]);
          },
        );
      },
    );
  }
}

class MovieGridShimmer extends StatelessWidget {
  final BoxConstraints parentConstraints;

  const MovieGridShimmer({Key? key, required this.parentConstraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            Get.mediaQuery.orientation == Orientation.portrait ? _portraitGridCellCount : _landscapeGridCellCount,
        childAspectRatio: _getDesiredGridCellAspectRatio(parentConstraints, Get.mediaQuery.orientation),
      ),
      itemCount: 4,
      itemBuilder: (_, __) {
        return MovieCardShimmer();
      },
    );
  }
}

class MovieCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Card(),
    );
  }
}

class MovieGridCell extends StatelessWidget {
  final SearchMovieInfo movieInfo;

  const MovieGridCell({Key? key, required this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListingCubit, MovieListingState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<MovieListingCubit>(context);

        return Card(
          child: InkWell(
            onTap: () => cubit.goToDetailsPage(movieInfo),
            child: LayoutBuilder(
              builder: (_, constraints) => Column(
                children: [
                  MovieImageWithInfo(movieInfo: movieInfo, parentConstraints: constraints),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        movieInfo.overview!,
                        style: getTextStyleCaption(context),
                        overflow: TextOverflow.ellipsis,
                        maxLines: Get.mediaQuery.orientation == Orientation.portrait ? 3 : 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MovieImageWithInfo extends StatelessWidget {
  final BaseCacheManager _cacheManager;
  final SearchMovieInfo movieInfo;
  final BoxConstraints parentConstraints;

  MovieImageWithInfo({required this.movieInfo, required this.parentConstraints})
      : _cacheManager = sl.get<BaseCacheManager>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: parentConstraints.maxWidth * 1.5,
      width: parentConstraints.maxWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: movieInfo.id!,
            child: CachedNetworkImage(
              cacheManager: _cacheManager,
              imageUrl: _getImageUrl(movieInfo.posterPath),
              placeholder: (context, url) => CircularProgressIndicator(),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: getColorOnSurface(context, opacity: opacityMin),
            ),
          ),
          Positioned(
            bottom: 16.0,
            width: parentConstraints.maxWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      movieInfo.title!,
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
                  _formatDate(movieInfo.releaseDate),
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

  String _formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return '-';
    }

    try {
      return dateFormatMMMyyyy(FlutterI18n.currentLocale(Get.context!).toString()).format(DateTime.parse(dateTime));
    } catch (_) {
      return '-';
    }
  }

  String _getImageUrl(String? posterUrl) {
    if (posterUrl == null || posterUrl.isEmpty) {
      return '${EnvConfig.placeholderEndpoint}/500x750.png?text=${FlutterI18n.translate(Get.context!, 'no_image_found')}';
    }

    return '${EnvConfig.tmdbApiImageEndpoint}/w500/${pathlib.basename(posterUrl)}';
  }
}

double _getDesiredGridCellAspectRatio(BoxConstraints constraints, Orientation orientation) {
  final itemHeight = constraints.maxHeight / 2;
  final itemWidth = constraints.maxWidth / 2;

  return orientation == Orientation.portrait ? itemWidth / itemHeight : itemHeight / itemWidth;
}
