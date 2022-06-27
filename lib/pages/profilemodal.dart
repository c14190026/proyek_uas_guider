// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, TODO, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/userdata.dart';

import '../dbservices.dart';
import '../widgets/tween.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _controllerName = TextEditingController();
  String _tempEmail = '';
  String _tempSubs = '';
  String _tempUrl = '';

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  void getUserData() {
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    final userData = Database.getData(uid: userUID);
    userData.then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        _controllerName.text = docSnap.get('userName').toString();
        setState(() {
          _tempEmail = docSnap.get('userEmail').toString();
          _tempSubs = docSnap.get('userSubs').toString();
          _tempUrl = docSnap.get('userPic').toString();
        });
      } else {
        print('Not Found');
      }
    });
  }

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  void updateProfile() {
    final dbUpdate = userDatabase(
        userName: _controllerName.text.trim(),
        userEmail: _tempEmail,
        userSubs: _tempSubs,
        userPic: _tempUrl);
    Database.updateData(
            user: dbUpdate, uid: FirebaseAuth.instance.currentUser!.uid)
        .whenComplete(() {
      Navigator.pop(context);
    });
  }

  imageChecker() {
    if (_tempUrl != '') {
      return _tempUrl;
    } else {
      return 'https://cdn.shopify.com/s/files/1/2198/0277/products/GPW-PW-029_2400x.jpg?v=1649783764';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'Change Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ShakesAnimation(
                  child: CachedNetworkImage(
                    cacheManager: customCacheManager,
                    key: UniqueKey(),
                    imageUrl: imageChecker(),
                    imageBuilder: (context, imageProvider) => Container(
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ShakesAnimation(
                  axis: Axis.vertical,
                  offset: 70,
                  curve: Curves.ease,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    //TODO Username
                    child: TextField(
                      controller: _controllerName,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFe0e0e0),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ShakesAnimation(
                  axis: Axis.vertical,
                  offset: 270,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: GestureDetector(
                          onTap: () {
                            updateProfile();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(40, 255, 255, 255),
                            ),
                            child: Icon(
                              LineIcons.save,
                              size: 45,
                              color: Color.fromARGB(225, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
