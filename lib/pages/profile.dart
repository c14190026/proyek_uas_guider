// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, unused_field, unnecessary_this, avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyek_uas_guider/main.dart';
import 'package:proyek_uas_guider/pages/login.dart';
import 'package:animations/animations.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageNetwork;

  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000,
        imageQuality: 100);
    if (image == null) return;

    final imageTemp = File(image.path);
    setState(() {
      this._imageNetwork = imageTemp;
      print(imageTemp);
    });
  }

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginAndSignUp(),
                  ),
                );
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextField(
                            focusNode: AlwaysDisabledFocusNode(),
                            readOnly: true,
                            controller: _controllerName,
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
    if (_imageNetwork != null) {
      return _imageNetwork!;
    } else {
      return 'https://images6.alphacoders.com/632/632060.jpg';
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
