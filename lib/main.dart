import 'package:auth_login/controlling.dart';
import 'package:auth_login/firebase_options.dart';
import 'package:auth_login/home.dart';
import 'package:auth_login/login.dart';
import 'package:auth_login/register.dart';
import 'package:auth_login/welcome.dart';
import 'package:auth_login/info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        textTheme: GoogleFonts.changaTextTheme(
          Theme.of(context).textTheme
        )
      ),
      //home: const HomePage(),
      initialRoute: '/',

      routes: {
        '/': (context) => WelcomePage(),
        '/RegisterPage': (context) => RegisterPage(),
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomePage(),
     },
    );
  }
}
