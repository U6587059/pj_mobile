import 'package:flutter/material.dart';
import 'kitchenpage.dart'; // Import the new pages
import 'cinema.dart';
import 'game.dart';
import 'meetingpage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const select_MyHomePage(),
    );
  }
}

class select_MyHomePage extends StatefulWidget {
  const select_MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<select_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const Center(
            child: Text(
              'ROOMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => kitchen()),
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/kitchen.jpg'),
                          fit: BoxFit
                              .cover, // ปรับให้รูปภาพตรงขอบและย่อลงเล็กน้อย
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Kitchen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => movie()),
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/movie.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Cinema',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => game()),
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/game.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Game',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => meeting()),
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/meeting.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Meeting Room',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
