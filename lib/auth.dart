import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/main.dart';
import 'package:proyek_uas_guider/pages/login.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!kIsWeb) {
      await Firebase.initializeApp();
    } else {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD7lyVamEs9SZXskZl_OMfaP3Sx8Asa5Gs",
            authDomain: "guider-app-e89dc.firebaseapp.com",
            projectId: "guider-app-e89dc",
            storageBucket: "guider-app-e89dc.appspot.com",
            messagingSenderId: "955506264112",
            appId: "1:955506264112:web:2b306d8ce729539ebd05f5",
            measurementId: "G-5GTM9C9MHN"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MyApp();
            } else {
              return const LoginAndSignUp();
            }
          },
        ),
      ),
    );
  }
}
