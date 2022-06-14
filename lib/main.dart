// ignore_for_file: prefer_const_constructorsoverride, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/pages/home.dart';
import 'package:proyek_uas_guider/pages/login.dart';
import 'package:proyek_uas_guider/pages/music.dart';
import 'package:proyek_uas_guider/pages/profile.dart';
import 'package:proyek_uas_guider/pages/subscription.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF151517),
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Color(0xFF151517),
    ),
  );

  runApp(
    MaterialApp(
      title: 'Guider',
      theme: new ThemeData(
        scaffoldBackgroundColor: Color(0xFF171717),
      ),
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
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF151517),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[300]!,
              gap: 8,
              activeColor: Color(0xFF151517),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[300]!,
              color: Color(0xFFa7a7a7),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.star,
                  text: 'Subs',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: activeIndex,
              onTabChange: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: pages[activeIndex],
    );
  }
}

// https://pub.dev/packages/curved_navigation_bar
