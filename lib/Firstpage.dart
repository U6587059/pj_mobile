import 'package:flutter/material.dart';
import 'loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('images/kave_main.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Adjust the alignment
                children: [
                  SizedBox(height: 100), // Add spacing above the logo
                  Center(
                    child: Column(
                      children: [
                        Image.asset('images/keke_logo.png',
                            width: 200, height: 200),
                        const SizedBox(
                            height: 40), // Add spacing below the logo
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Welcome back, log in with your account.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 40), // Add spacing below the logo and message
                  Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                          fillColor: Colors.black,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          labelText: 'enter your Email ',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่อีเมล';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Email: ${_emailController.text}');
                            // Navigate to LoginScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage()), // Corrected: Should be LoginScreen()
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          'ค้นหาบัญชี',
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
