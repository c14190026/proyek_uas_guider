// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFF171717),
        body: SafeArea(
          bottom: true,
          top: false,
          child: Expanded(
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images6.alphacoders.com/632/632060.jpg'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Color.fromARGB(100, 23, 23, 23),
                        Color(0xFF171717),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
