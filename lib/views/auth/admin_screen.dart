import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/auth_service.dart';
import 'package:afterschool_center/models/user_model.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('管理中心'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            StreamBuilder<UserModel?>(
              stream: user,
              builder: (context, snapshot) {
                final user = snapshot.data;
                return UserAccountsDrawerHeader(
                  accountName: Text(user?.name ?? '管理员'),
                  accountEmail: Text(user?.email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('用户管理'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UserManagementScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('课程管理'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CourseManagementScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('数据统计'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AnalyticsScreen(),
                ));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('欢迎使用课后中心管理系统', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// 以下是示例的子页面，你需要根据实际需求完善

class UserManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户管理')),
      body: ListView(
        children: [
          // 这里添加用户列表
          ListTile(
            title: Text('教师1'),
            subtitle: Text('teacher1@example.com'),
            trailing: Icon(Icons.edit),
          ),
          // 更多用户...
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 添加新用户
        },
      ),
    );
  }
}

class CourseManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课程管理')),
      body: ListView(
        children: [
          // 课程列表
          Card(
            child: ListTile(
              title: Text('数学辅导'),
              subtitle: Text('周一、周三 16:00-18:00'),
              trailing: Icon(Icons.edit),
            ),
          ),
          // 更多课程...
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 添加新课程
        },
      ),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('数据统计')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('本月活跃用户', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('128', style: TextStyle(fontSize: 32)),
                  ],
                ),
              ),
            ),
            // 更多统计卡片...
          ],
        ),
      ),
    );
  }
}