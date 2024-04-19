import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: game(),
    );
  }
}

class game extends StatefulWidget {
  @override
  _gamePageState createState() => _gamePageState();
}

class  _gamePageState extends State<game> {
  String _roomName = '';
  String _startTime = '09:00';
  String _endTime = '09:30';
  DateTime _selectedDate = DateTime.now();
  TextEditingController _roomController = TextEditingController(
      text:
          'Game Room'); // ตั้งค่าเริ่มต้นให้ช่อง 'ROOM' เป็น 'MEETING ROOM'

  // Generate time slots from 09:00 to 22:00 with 30 minutes interval
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

  // Generate time slots for a maximum duration of 4 hours from the specified start time
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

  // Calculate the end time based on the start time
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(Duration(days: 2)), // จำกัดให้เลือกได้ล่วงหน้า 2 วัน
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
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
              // Wrapping the image with Transform.scale
              Transform.scale(
                scale: 1, // Adjust the scale factor as needed
                child: Image.asset('images/game.jpg'),
              ),
              SizedBox(height: 40.0),
              TextField(
                controller: _roomController, // ใช้ controller ที่กำหนดไว้
                readOnly: true, // ตั้งให้ไม่สามารถแก้ไขได้
                decoration: InputDecoration(
                  labelText: 'ROOM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _roomName = value;
                  });
                },
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          "${_selectedDate.toLocal()}".split(' ')[0],
                        ),
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
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
                onPressed: () {
                  print(
                      'จองห้อง $_roomName วันที่ ${_selectedDate.toLocal()} ตั้งแต่ $_startTime ถึง $_endTime');
                  // Add booking logic here
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
