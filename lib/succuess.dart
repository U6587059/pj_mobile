import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การยืนยันการจอง'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement logout action
              print('Logout');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 110.0,
                  color: Colors.green,
                ),
                const SizedBox(width: 16.0),
                const Text(
                  'Successfully!',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold), // ขยายข้อความใหญ่ขึ้น
                ),
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
                  const Text(
                    'รายละเอียดการจอง',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold), // ขยายข้อความใหญ่ขึ้น
                  ),
                  const SizedBox(height: 16.0),
                  _buildDetailRow('เลขห้อง:', 'C 427'),
                  _buildDetailRow('Booking ID:', '#5448'),
                  _buildDetailRow('วันที่:', '17/03/2024'),
                  _buildDetailRow('ห้อง:', 'Kitchen Room'),
                  _buildDetailRow('เวลาเริ่ม:', '9:30 AM'),
                  _buildDetailRow('เวลาสิ้นสุด:', '12:30 PM'),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement finish action
                print('กดปุ่ม Finish');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text('Finish'), const SizedBox(width: 8.0)],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Please capture the screen as evidence',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.red), // ขยายข้อความใหญ่ขึ้น
            ),
          ],
        ),
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
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold), // ขยายข้อความใหญ่ขึ้น
          ),
          const SizedBox(width: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: 18.0), // ขยายข้อความใหญ่ขึ้น
          ),
        ],
      ),
    );
  }
}
