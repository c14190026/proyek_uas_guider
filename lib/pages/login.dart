// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, TODO

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/dbservices.dart';
import 'package:proyek_uas_guider/userdata.dart';
import '../widgets/tween.dart';

class LoginAndSignUp extends StatefulWidget {
  const LoginAndSignUp({Key? key}) : super(key: key);

  @override
  State<LoginAndSignUp> createState() => _LoginAndSignUpState();
}

class _LoginAndSignUpState extends State<LoginAndSignUp> {
  bool _passwordHiddenLogin = true;
  bool _passwordHiddenCreate = true;

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _ShowHidePasswordLogin() {
    if (mounted) {
      setState(() {
        _passwordHiddenLogin = !_passwordHiddenLogin;
      });
    }
  }

  void _ShowHidePasswordCreate() {
    if (mounted) {
      setState(() {
        _passwordHiddenCreate = !_passwordHiddenCreate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 34, 37),
      body: PageView(
        children: [
          //TODO HALAMAN LOGIN
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShakesAnimation(
                            offset: 80,
                            child: Text(
                              "WELCOME",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ShakesAnimation(
                            offset: 60,
                            child: Text(
                              "BACK",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: TextField(
                        controller: _controllerEmail,
                        style: (TextStyle(
                          color: Colors.grey,
                        )),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 65, 64, 64),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          label: Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _controllerPassword,
                      obscureText: _passwordHiddenLogin,
                      style: (TextStyle(
                        color: Colors.grey,
                      )),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 65, 64, 64),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        label: Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(
                            _passwordHiddenLogin == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _ShowHidePasswordLogin();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,

                        // child: IconButton(
                        //   color: Color.fromARGB(255, 16, 126, 141),
                        //   iconSize: 30,
                        //   onPressed: () {},
                        //   icon: Icon(Icons.login),
                        // ),

                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "LOG IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onPressed: () {
                              //TODO SignIn Auth
                              Auth.signIn(
                                email: _controllerEmail.text.trim(),
                                password: _controllerPassword.text.trim(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    ShakesAnimation(
                      axis: Axis.vertical,
                      offset: 70,
                      curve: Curves.ease,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 60, 0, 20),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.swipe_left,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        style: BorderStyle.solid,
                                        width: 4,
                                        color: Colors.lightGreenAccent,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Swipe Left to Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //TODO HALAMAN SIGN UP
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShakesAnimation(
                            offset: 80,
                            child: Text(
                              "CREATE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ShakesAnimation(
                            offset: 60,
                            child: Text(
                              "ACCOUNT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextField(
                        controller: _controllerName,
                        style: (TextStyle(
                          color: Colors.grey,
                        )),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 65, 64, 64),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          label: Text(
                            "Username",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: TextField(
                        controller: _controllerEmail,
                        style: (TextStyle(
                          color: Colors.grey,
                        )),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 65, 64, 64),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          label: Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _controllerPassword,
                      obscureText: _passwordHiddenCreate,
                      style: (TextStyle(
                        color: Colors.grey,
                      )),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 65, 64, 64),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        label: Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(
                            _passwordHiddenCreate == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _ShowHidePasswordCreate();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,

                        // child: IconButton(
                        //   color: Color.fromARGB(255, 16, 126, 141),
                        //   iconSize: 30,
                        //   onPressed: () {},
                        //   icon: Icon(Icons.login),
                        // ),

                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onPressed: () {
                              //TODO SignUp Auth

                              Auth.signUp(
                                email: _controllerEmail.text.trim(),
                                password: _controllerPassword.text.trim(),
                              ).then(
                                (value) {
                                  final userData = userDatabase(
                                      userName: _controllerName.text
                                          .trim()
                                          .toString(),
                                      userEmail: _controllerEmail.text
                                          .trim()
                                          .toString(),
                                      userSubs: '',
                                      userPic: '');
                                  Database.addData(
                                    user: userData,
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    ShakesAnimation(
                      axis: Axis.vertical,
                      offset: 70,
                      curve: Curves.ease,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 60, 0, 20),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.swipe_right,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        style: BorderStyle.solid,
                                        width: 4,
                                        color: Colors.lightGreenAccent,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Swipe Right to Login In",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
