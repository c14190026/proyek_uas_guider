// ignore_for_file: TODO, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/widgets/youtubeplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtFullScreen extends StatefulWidget {
  final String ytLink;
  final Duration currPos;
  const YtFullScreen({Key? key, required this.ytLink, required this.currPos})
      : super(key: key);

  @override
  State<YtFullScreen> createState() => _YtFullScreenState();
}

class _YtFullScreenState extends State<YtFullScreen> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
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
      initialVideoId: YoutubePlayer.convertUrlToId(widget.ytLink)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..seekTo(widget.currPos, allowSeekAhead: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final device_height = MediaQuery.of(context).size.height;
    // final device_width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Expanded(
          child: Align(
            child: FittedBox(
              child: YtPlayer(
                Youtube_link: widget.ytLink,
                currPos: _youtubePlayerController.value.position,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
