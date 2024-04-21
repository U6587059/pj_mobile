import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cinema.dart';
import 'error.dart';
import 'package:pj_mobile/Firstpage.dart';
import 'package:pj_mobile/game.dart';
import 'package:pj_mobile/kitchenpage.dart';
import 'package:pj_mobile/meetingpage.dart';
import 'package:pj_mobile/success.dart';
import 'package:pj_mobile/select_room.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => LoginScreen(), 
      },
      initialRoute: "/",
    );
  }
}
