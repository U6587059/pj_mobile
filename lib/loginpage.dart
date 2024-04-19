import 'package:flutter/material.dart';
import 'select_room.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WELCOME BACK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _roomNumberController = TextEditingController(text: 'C 427');

  @override
  void dispose() {
    _passwordController.dispose();
    _roomNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME BACK'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // ห่อ Form ด้วย SingleChildScrollView
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image display
                Image.asset('images/profile.png'),

                SizedBox(height: 8.0),

                // Room Number text field
                TextField(
                  controller: _roomNumberController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    labelText: 'ROOM',
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                ),

                SizedBox(height: 16.0),

                // Password text field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // Login button
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process login
                      print('Room Number: ${_roomNumberController.text}');
                      print('Password: ${_passwordController.text}');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           select_MyHomePage()), // Corrected: Should be LoginScreen()
                    );
                  },
                  child: Text('LOGIN', style: TextStyle(fontSize: 16.0)),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
