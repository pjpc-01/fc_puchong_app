import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/auth_service.dart';

class ParentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('家长面板'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('家长主页 - 待开发'),
      ),
    );
  }
}