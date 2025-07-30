import 'package:flutter/material.dart';
import '../models/student_model.dart'; // 确保路径正确

class AttendanceTile extends StatelessWidget {
  final Student student;
  final ValueChanged<bool> onChanged;

  const AttendanceTile({required this.student, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: Switch(
        value: student.isPresent,
        onChanged: onChanged,
      ),
    );
  }
}
