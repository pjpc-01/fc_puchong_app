import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/database_service.dart';
import 'package:afterschool_center/models/class_model.dart';
import 'package:afterschool_center/views/admin/add_class_screen.dart';

class ManageClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('班级管理')),
      body: StreamBuilder<List<ClassModel>>(
        stream: Provider.of<DatabaseService>(context).getClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('没有班级数据'));
          }
          
          final classes = snapshot.data!;
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classItem = classes[index];
              return ListTile(
                title: Text(classItem.name),
                subtitle: Text('教师ID: ${classItem.teacherId}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // 编辑班级
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddClassScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}