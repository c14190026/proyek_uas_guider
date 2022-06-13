// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Color(0xFF2b2b38),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/736x/0c/8b/fd/0c8bfd8351ead3deb559911dd00dd018.jpg"),
                    ),

                    // CachedNetworkImage(
                    //   imageUrl:
                    //       "https://i.pinimg.com/736x/0c/8b/fd/0c8bfd8351ead3deb559911dd00dd018.jpg",
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: imageProvider,
                    //           fit: BoxFit.cover,
                    //           colorFilter: ColorFilter.mode(
                    //               Colors.red, BlendMode.colorBurn)),
                    //     ),
                    //   ),
                    //   placeholder: (context, url) =>
                    //       CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
