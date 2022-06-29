// ignore_for_file: TODO, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/widgets/youtubeplayer.dart';

class YtFullScreen extends StatefulWidget {
  final String ytLink;
  const YtFullScreen({Key? key, required this.ytLink}) : super(key: key);

  @override
  State<YtFullScreen> createState() => _YtFullScreenState();
}

class _YtFullScreenState extends State<YtFullScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Expanded(
          child: Align(
            child: FittedBox(
              child: YtPlayer(
                Youtube_link: widget.ytLink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
