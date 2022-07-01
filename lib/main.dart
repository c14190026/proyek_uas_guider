// ignore_for_file: prefer_const_constructorsoverride, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, TODO

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/auth.dart';
import 'package:proyek_uas_guider/pages/home.dart';
import 'package:proyek_uas_guider/pages/music.dart';
import 'package:proyek_uas_guider/pages/profile.dart';
import 'package:proyek_uas_guider/pages/subscription.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: Auth(),
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
    if (mounted) {
      if (mounted) {
        setState(() {
          activeIndex = index;
        });
      }
    }
  }

  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      Home(),
      Music(),
      Subscription(),
      Profile(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              rippleColor: Color.fromARGB(15, 224, 224, 224),
              hoverColor: Color.fromARGB(15, 224, 224, 224),
              gap: 8,
              activeColor: Color.fromARGB(225, 255, 255, 255),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: Color.fromARGB(15, 224, 224, 224),
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
<<<<<<< HEAD
=======
                  icon: LineIcons.history,
                  text: 'History',
                ),
                GButton(
>>>>>>> parent of 86a1eed (player onplay error)
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: activeIndex,
              onTabChange: (index) {
                if (mounted) {
                  if (mounted) {
                    setState(
                      () {
                        activeIndex = index;
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
      body: pages[activeIndex],
    );
  }
}
