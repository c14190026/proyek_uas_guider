// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';

class LoginAndSignUp extends StatefulWidget {
  const LoginAndSignUp({Key? key}) : super(key: key);

  @override
  State<LoginAndSignUp> createState() => _LoginAndSignUpState();
}

class _LoginAndSignUpState extends State<LoginAndSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 34, 37),
      body: SingleChildScrollView(
        child: PageView(
          children: [
            //HALAMAN LOGIN
            Padding(
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
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
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
                            onPressed: () {},
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
            //HALAMAN SIGN UP
            Padding(
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
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
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
                            onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}

class ShakesAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final double begin_tween;
  final double end_tween;
  final Axis axis;
  final Curve curve;

  const ShakesAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.offset = 140.0,
    this.begin_tween = 1,
    this.end_tween = 0,
    this.axis = Axis.horizontal,
    this.curve = Curves.bounceOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin_tween, end: end_tween),
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(
                  value * offset,
                  0.0,
                )
              : Offset(
                  0.0,
                  value * offset,
                ),
          child: child,
        );
      },
    );
  }
}
