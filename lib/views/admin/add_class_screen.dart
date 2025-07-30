import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/database_service.dart';
import 'package:afterschool_center/models/class_model.dart';

class AddClassScreen extends StatefulWidget {
  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _teacherIdController = TextEditingController();
  final _scheduleController = TextEditingController();
  final _studentIdsController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加班级')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '班级名称'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入班级名称';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _teacherIdController,
                decoration: InputDecoration(labelText: '教师ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入教师ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _scheduleController,
                decoration: InputDecoration(labelText: '课程安排'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入课程安排';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _studentIdsController,
                decoration: InputDecoration(labelText: '学生ID（用逗号分隔）'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入学生ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text('添加班级'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final classModel = ClassModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        teacherId: _teacherIdController.text.trim(),
        studentIds: _studentIdsController.text.trim().split(','),
        schedule: _scheduleController.text.trim(),
      );

      await Provider.of<DatabaseService>(context, listen: false)
          .addClass(classModel);

      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _teacherIdController.dispose();
    _scheduleController.dispose();
    _studentIdsController.dispose();
    super.dispose();
  }
}