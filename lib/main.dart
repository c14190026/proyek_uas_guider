// ignore_for_file: prefer_const_constructorsoverride, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyek_uas_guider/pages/home.dart';
import 'package:proyek_uas_guider/pages/music.dart';
import 'package:proyek_uas_guider/pages/profile.dart';
import 'package:proyek_uas_guider/pages/subscription.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Guider',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int activeIndex = 0;
  void changeActivePage(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      // Home(() => changeActivePage(2)),
      Home(),
      Music(),
      Subscription(),
      Profile(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF1e1e2a),
        statusBarColor: Color(0xFF1e1e2a),
        systemNavigationBarDividerColor: Color(0xFF1e1e2a),
      ),
    );
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xFF2b2b38),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => changeActivePage(0),
                icon: Icon(
                  Icons.home_filled,
                  color: Color(0xFFfdfeff),
                ),
              ),
              IconButton(
                onPressed: () => changeActivePage(1),
                icon: Icon(
                  Icons.library_music,
                  color: Color(0xFFfdfeff),
                ),
              ),
              IconButton(
                onPressed: () => changeActivePage(2),
                icon: Icon(
                  Icons.star_half_rounded,
                  color: Color(0xFFfdfeff),
                ),
              ),
              IconButton(
                onPressed: () => changeActivePage(3),
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFfdfeff),
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[activeIndex],
    );
  }
}

// https://pub.dev/packages/curved_navigation_bar
