import 'package:flutter/material.dart';
import 'loginpage.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/kave_main.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100),  
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset('images/keke_logo.png', width: 200, height: 200),
                          const SizedBox(height: 40),  
                          Text(
                            'HELLO',
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'WELCOME TO KEKE CONDO APPLICATION',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                            ),
                            child: Text(
                              'GET START',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
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
    );
  }
}