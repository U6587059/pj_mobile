import 'package:flutter/material.dart';
import 'cinema.dart';
import 'error.dart';
import 'package:pj_mobile/Firstpage.dart';
import 'package:pj_mobile/game.dart';
import 'package:pj_mobile/kitchenpage.dart';
import 'package:pj_mobile/main_page.dart';
import 'package:pj_mobile/meetingpage.dart';
import 'package:pj_mobile/succuess.dart';
import 'package:pj_mobile/select_room.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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