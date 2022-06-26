// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            child: CustomScrollView(
              slivers: [SliverAppBar()],
            ),
          ),
        ),
      ),
    );
  }
}
