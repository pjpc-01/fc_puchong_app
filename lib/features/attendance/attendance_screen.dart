import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Student> _students = [];
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final snapshot = await FirebaseFirestore.instance.collection('students').get();
    final students = snapshot.docs.map((doc) => Student.fromMap(doc.data())).toList();
    setState(() {
      _students = students;
    });
  }

  void _markAttendance(Student student, bool isPresent) {
    // 保存到 Firestore
    FirebaseFirestore.instance
        .collection('attendance')
        .doc('${student.id}_${_selectedDate.toIso8601String().substring(0, 10)}')
        .set({
      'studentId': student.id,
      'date': _selectedDate,
      'isPresent': isPresent,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('每日考勤')),
      body: Column(
        children: [
          CalendarPicker(onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
            });
          }),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (ctx, index) => AttendanceTile(
                student: _students[index],
                onChanged: (val) => _markAttendance(_students[index], val),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
