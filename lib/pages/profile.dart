// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, unused_field, unnecessary_this, avoid_print, prefer_typing_uninitialized_variables, TODO

import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/widgets/tween.dart';
import 'package:proyek_uas_guider/dbservices.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future getImage() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (res == null) {}

    final path = res!.files.single.path;

    FireStorage.updateProfilePic(
        filepath: path, uid: FirebaseAuth.instance.currentUser!.uid);
  }

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSubs = TextEditingController();
  var _tempImg;

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerSubs.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final userUID = FirebaseAuth.instance.currentUser?.uid;
    print(userUID);
    // TODO: implement initState
    final userData = Database.getData(uid: userUID);
    userData.then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        _controllerName.text = docSnap.get('userName').toString();
        _controllerEmail.text = docSnap.get('userEmail').toString();
        _controllerSubs.text = docSnap.get('userSubs').toString();
        if (_controllerSubs.text == '') {
          _controllerSubs.text = 'No Subs';
        }
        _tempImg = docSnap.get('userSubs').toString();
      } else {
        print('Not Found');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height_stack = MediaQuery.of(context).size.height;
    var width_stack = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              //TODO SignOut Auth
              onTap: () {
                Auth.signOut();
              },
              child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(40, 255, 255, 255),
                  ),
                  child: Icon(
                    LineIcons.doorOpen,
                    size: 25,
                    color: Color.fromARGB(225, 255, 255, 255),
                  )),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF171717),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Expanded(
          child: Stack(
            children: [
              //TODO Bg Image
              CachedNetworkImage(
                imageUrl: imageChecker(),
                imageBuilder: (context, imageProvider) => Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0),
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
              ),
              SingleChildScrollView(
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 125),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  getImage();
                                },
                                //TODO Profile Pic
                                child: CachedNetworkImage(
                                  imageUrl: imageChecker(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ShakesAnimation(
                          axis: Axis.vertical,
                          offset: 70,
                          curve: Curves.ease,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //TODO Username
                            child: TextField(
                              focusNode: AlwaysDisabledFocusNode(),
                              readOnly: true,
                              controller: _controllerName,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    print('Tapped');
                                  },
                                  child: Icon(LineIcons.edit),
                                ),
                                suffixIconColor: Color(0xFF171717),
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
                          offset: 170,
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 1000),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //TODO Email
                            child: TextField(
                              focusNode: AlwaysDisabledFocusNode(),
                              readOnly: true,
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    print('Tapped');
                                  },
                                  child: Icon(LineIcons.edit),
                                ),
                                filled: true,
                                fillColor: Color(0xFFe0e0e0),
                                hintText: 'Email',
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
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextField(
                              //TODO Subs
                              focusNode: AlwaysDisabledFocusNode(),
                              readOnly: true,
                              controller: _controllerSubs,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFe0e0e0),
                                hintText: 'Subscription',
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  imageChecker() {
    if (_tempImg != null) {
      return _tempImg;
    } else {
      return 'https://images6.alphacoders.com/632/632060.jpg';
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
