import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/auth_service.dart';
import 'package:afterschool_center/utils/validator.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'teacher';
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.registerUser(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
        _selectedRole,
      );

      setState(() => _isLoading = false);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户添加成功')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('添加失败，用户名已存在')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('添加用户')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '姓名'),
                validator: Validator.validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: '用户名'),
                validator: Validator.validateUsername,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
                validator: Validator.validatePassword,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: ['admin', 'teacher', 'parent', 'student']
                    .map((role) => DropdownMenuItem(
                  value: role,
                  child: Text({
                    'admin': '管理员',
                    'teacher': '老师',
                    'parent': '家长',
                    'student': '学生',
                  }[role]!),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val!),
                decoration: const InputDecoration(labelText: '角色'),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _submit,
                child: const Text('添加用户'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
