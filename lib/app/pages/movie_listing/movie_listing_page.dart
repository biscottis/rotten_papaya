import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:rotten_papaya/app/theme.dart';
import 'package:rotten_papaya/app/utils/service_locator.dart';
import 'package:rotten_papaya/app/utils/text_utils.dart';

class MovieListingPage extends StatefulWidget {
  @override
  _MovieListingPageState createState() => _MovieListingPageState();
}

class _MovieListingPageState extends State<MovieListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'rotten_papaya')),
        backgroundColor: getColorPrimary(context),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: _getDesiredGridCellAspectRatio(constraints),
            ),
            itemCount: 100,
            itemBuilder: (context, index) {
              return MovieGridCell();
            },
          ),
        ),
      ),
    );
  }

  double _getDesiredGridCellAspectRatio(BoxConstraints constraints) {
    final itemHeight = constraints.maxHeight / 2;
    final itemWidth = constraints.maxWidth / 2;

    return itemWidth / itemHeight;
  }
}

class MovieGridCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          MovieImageWithInfo(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics\' publications in the 1990s.',
                style: getTextStyleCaption(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieImageWithInfo extends StatelessWidget {
  final BaseCacheManager _cacheManager;

  MovieImageWithInfo() : _cacheManager = sl.get<BaseCacheManager>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          cacheManager: _cacheManager,
          imageUrl:
              'https://image.tmdb.org/t/p/w500/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg',
          progressIndicatorBuilder: (_, __, downloadProgress) =>
              CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
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
                    'Batman v Superman: Dawn of Justice',
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
                _formatDate(DateTime.parse('2007-09-18')),
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
    );
  }

  String _formatDate(DateTime dateTime) {
    return dateFormatMMMyyyy(FlutterI18n.currentLocale(Get.context).toString())
        .format(dateTime);
  }
}
