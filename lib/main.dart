import 'package:flutter/material.dart';
import 'meetingpage.dart'; // นำเข้าไฟล์ booking_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BookingPage(), // ตั้งค่าหน้า BookingPage เป็นหน้าจอเริ่มต้น
    );
  }
}
