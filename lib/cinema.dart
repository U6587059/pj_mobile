import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'error.dart';
import 'success.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CinemaRoom(),
    );
  }
}

class CinemaRoom extends StatefulWidget {
  @override
  _CinemaRoomState createState() => _CinemaRoomState();
}

class _CinemaRoomState extends State<CinemaRoom> {
  String _roomName = 'CINEMA ROOM';
  String _startTime = '09:00';
  String _endTime = '09:30';
  DateTime _selectedDate = DateTime.now();
  TextEditingController _roomController =
      TextEditingController(text: 'CINEMA ROOM');

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 9; hour <= 22; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String hourStr = hour.toString().padLeft(2, '0');
        String minuteStr = minute.toString().padLeft(2, '0');
        timeSlots.add('$hourStr:$minuteStr');
      }
    }
    return timeSlots;
  }

  List<String> _generateEndTimeSlots(String startTime) {
    List<String> endTimeSlots = [];
    int startHour = int.parse(startTime.substring(0, 2));
    int startMinute = int.parse(startTime.substring(3, 5));
    int maxHour = startHour + 4;
    if (maxHour > 22) {
      maxHour = 22;
    }
    for (int hour = startHour; hour <= maxHour; hour++) {
      for (int minute = (hour == startHour ? startMinute + 30 : 0);
          minute < 60;
          minute += 30) {
        String hourStr = hour.toString().padLeft(2, '0');
        String minuteStr = minute.toString().padLeft(2, '0');
        endTimeSlots.add('$hourStr:$minuteStr');
      }
    }
    return endTimeSlots;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 2)), // Extended to allow booking up to one year in advance
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void checkAndBookRoom() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot metadata =
        await firestore.collection('metadata').doc('bookingID').get();
    int currentBookingId = metadata.exists ? metadata['lastId'] : 4999;

    DateTime selectedDay =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    DateTime startTime = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
        int.parse(_startTime.split(':')[0]),
        int.parse(_startTime.split(':')[1]));
    DateTime endTime = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
        int.parse(_endTime.split(':')[0]),
        int.parse(_endTime.split(':')[1]));

    QuerySnapshot query = await firestore
        .collection('bookings')
        .where('room', isEqualTo: _roomName)
        .where('date',
            isEqualTo: selectedDay.toLocal().toString().split(' ')[0])
        .get();

    bool isOverlap = query.docs.any((doc) {
      DateTime existingStartTime =
          DateTime.parse(doc['date'] + ' ' + doc['startTime']);
      DateTime existingEndTime =
          DateTime.parse(doc['date'] + ' ' + doc['endTime']);
      return (startTime.isBefore(existingEndTime) &&
          endTime.isAfter(existingStartTime));
    });

    if (isOverlap) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BookingErrorScreen()));
    } else {
      int newBookingId = currentBookingId + 1;

      await firestore.collection('bookings').add({
        'room': _roomName,
        'date': selectedDay.toLocal().toString().split(' ')[0],
        'startTime': _startTime,
        'endTime': _endTime,
        'bookingId': newBookingId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await firestore
          .collection('metadata')
          .doc('bookingID')
          .set({'lastId': newBookingId});

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfirmationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = _generateTimeSlots();
    List<String> endTimeSlots = _generateEndTimeSlots(_startTime);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                  'images/movie.jpg'), // Image changed to represent a cinema room
              SizedBox(height: 16.0),
              TextField(
                controller: _roomController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'ROOM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'DATE',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${_selectedDate.toLocal()}".split(' ')[0]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'START',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _startTime,
                        onChanged: (String? newValue) {
                          setState(() {
                            _startTime = newValue!;
                            _endTime = _calculateEndTime(newValue);
                            endTimeSlots = _generateEndTimeSlots(newValue);
                          });
                        },
                        items: timeSlots
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'END',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _endTime,
                        onChanged: (String? newValue) {
                          setState(() {
                            _endTime = newValue!;
                          });
                        },
                        items: endTimeSlots
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: checkAndBookRoom,
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateEndTime(String startTime) {
    int startHour = int.parse(startTime.substring(0, 2));
    int startMinute = int.parse(startTime.substring(3, 5));
    int endHour = startHour + 4;
    if (endHour > 22) {
      endHour = 22;
    }
    int endMinute = startMinute;
    return '$endHour:${endMinute.toString().padLeft(2, '0')}';
  }
}
