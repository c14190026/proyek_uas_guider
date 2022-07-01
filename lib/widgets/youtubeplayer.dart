// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, TODO

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayer extends StatefulWidget {
  final DocumentSnapshot YtData;
  const YtPlayer({Key? key, required this.YtData}) : super(key: key);

  @override
  State<YtPlayer> createState() => _YtPlayerState();
}

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
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.YtData['link']).toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Expanded(
          child: Align(
            child: FittedBox(
              child: Wrap(
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
                                  'https://www.freeiconspng.com/thumbs/load-icon-png/load-icon-png-8.png',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
