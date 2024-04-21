import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'select_room.dart'; 
import 'loginpage.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirmation Screen',
      home: ConfirmationScreen(),
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  Future<Map<String, dynamic>?> fetchLastBooking() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection('bookings')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data() as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การยืนยันการจอง'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage()), 
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchLastBooking(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching booking details.'));
          } else if (snapshot.hasData) {
            return buildConfirmationPage(snapshot.data!);
          } else {
            return const Center(child: Text('No booking found.'));
          }
        },
      ),
    );
  }

  Widget buildConfirmationPage(Map<String, dynamic> bookingData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline,
                  size: 110.0, color: Colors.green),
              const SizedBox(width: 16.0),
              const Text('Successfully!',
                  style:
                      TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 32.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('รายละเอียดการจอง',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16.0),
                _buildDetailRow(
                    'Booking ID:', bookingData['bookingId'].toString()),
                _buildDetailRow('วันที่:', bookingData['date']),
                _buildDetailRow('ห้อง:', bookingData['room']),
                _buildDetailRow('เวลาเริ่ม:', bookingData['startTime']),
                _buildDetailRow('เวลาสิ้นสุด:', bookingData['endTime']),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        select_MyHomePage()), 
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [const Text('Finish'), const SizedBox(width: 8.0)],
            ),
          ),
          const SizedBox(height: 8.0),
          const Text('Please capture the screen as evidence',
              style: TextStyle(fontSize: 20.0, color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
