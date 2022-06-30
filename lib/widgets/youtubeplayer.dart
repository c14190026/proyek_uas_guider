// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, TODO

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/widgets/ytfullscreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayer extends StatefulWidget {
  final String Youtube_link;
  const YtPlayer({Key? key, required this.Youtube_link}) : super(key: key);

  @override
  State<YtPlayer> createState() => _YtPlayerState();
}

bool check = false;

class _YtPlayerState extends State<YtPlayer> {
  late YoutubePlayerController _youtubePlayerController;

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  void deactivate() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.Youtube_link)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
    // ..seekTo(widget.currPos, allowSeekAhead: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: YoutubePlayer(
                thumbnail: Opacity(
                  opacity: 0,
                  child: CachedNetworkImage(
                    cacheManager: customCacheManager,
                    key: UniqueKey(),
                    imageUrl:
                        'https://e1.pngegg.com/pngimages/614/418/png-clipart-jsplaylist-loading-icon-thumbnail.png',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                key: UniqueKey(),
                aspectRatio: 16 / 9,
                bottomActions: [
                  CurrentPosition(
                    controller: _youtubePlayerController,
                  ),
                  ProgressBar(
                    controller: _youtubePlayerController,
                    isExpanded: true,
                  ),
                  RemainingDuration(
                    controller: _youtubePlayerController,
                  ),
                  PlaybackSpeedButton(
                    controller: _youtubePlayerController,
                  ),
                ],
                controller: _youtubePlayerController,
                
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  if (!check) {
                    check = true;
                    SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.immersiveSticky);
                    SystemChrome.setPreferredOrientations(
                      [
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight
                      ],
                    );

                    deactivate();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YtFullScreen(
                          ytLink: widget.Youtube_link,
                        ),
                      ),
                    ).then((value) {
                      check = false;
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: SystemUiOverlay.values);
                      SystemChrome.setPreferredOrientations(
                        [
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown
                        ],
                      );
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  !check ? LineIcons.expand : LineIcons.expand,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
