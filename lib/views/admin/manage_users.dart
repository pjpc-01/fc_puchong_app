import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/models/user_model.dart';
import 'package:afterschool_center/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ManageUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户管理')),
      body: StreamBuilder<List<UserModel>>(
        stream: _getUsersStream(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('暂无用户数据'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('${user.username} - ${user.role}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editUser(context, user),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Stream<List<UserModel>> _getUsersStream(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .toList());
  }

  void _editUser(BuildContext context, UserModel user) {
    // 实现编辑逻辑
  }
}