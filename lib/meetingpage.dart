import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Meeting(),
    );
  }
}

class Meeting extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<Meeting> {
  String _roomName = 'MEETING ROOM';
  String _startTime = '09:00';
  String _endTime = '09:30';
  DateTime _selectedDate = DateTime.now();
  TextEditingController _roomController = TextEditingController(text: 'MEETING ROOM');

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
      for (int minute = (hour == startHour ? startMinute + 30 : 0); minute < 60; minute += 30) {
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
      lastDate: DateTime.now().add(Duration(days: 2)),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void checkAndBookRoom() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot query = await firestore.collection('bookings').where('room', isEqualTo: _roomName).where('date', isEqualTo: _selectedDate.toLocal().toString().split(' ')[0]).where('startTime', isEqualTo: _startTime).where('endTime', isEqualTo: _endTime).get();

    if (query.docs.isNotEmpty) {
      Navigator.pushNamed(context, '/error');
    } else {
      await firestore.collection('bookings').add({
        'room': _roomName,
        'date': _selectedDate.toLocal().toString().split(' ')[0],
        'startTime': _startTime,
        'endTime': _endTime,
      });
      Navigator.pushNamed(context, '/success');
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
              Image.asset('images/meeting.jpg'),
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
                        items: timeSlots.map<DropdownMenuItem<String>>((String value) {
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
                        items: endTimeSlots.map<DropdownMenuItem<String>>((String value) {
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
