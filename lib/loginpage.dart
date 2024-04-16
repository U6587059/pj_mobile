import 'package:flutter/material.dart';

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
  final _roomNumberController = TextEditingController();

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image display
              Image.asset('images/profile.png'),

              // Room Number label
              Text(
                'ROOM NUMBER',
                style: TextStyle(fontSize: 16.0),
              ),

              // Spacing between label and text field
              SizedBox(height: 8.0), // Add a vertical gap

              // Room Number text field
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: StadiumBorder(),
                ),
                child: TextFormField(
                  controller: _roomNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter Room Number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),

              // Password input field
              SizedBox(height: 24.0),
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: StadiumBorder(),
                ),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),

              // Submit button
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle password submission and potentially room number
                    print('Password: ${_passwordController.text}');
                    print('Room Number: ${_roomNumberController.text}');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
