// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, TODO

import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/widgets/youtubeplayer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String yt_link = '';

  @override
  void initState() {
    // TODO: implement initState
    yt_link =
        'https://youtu.be/8fLie0tmhcA?list=PLl6facSXoKMrBxF3dQ4StdqtTJtfuxkZ5';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: YtPlayer(
              Youtube_link: yt_link,
              currPos: const Duration(seconds: 0),
            ),
          ),
        ),
      ),
    );
  }
}

// Builder(
//                 builder: (BuildContext context) =>
//                     YtPlayer(Youtube_link: yt_link),
//               ),