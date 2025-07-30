import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String _role = 'teacher'; // 默认角色
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      print("❌ 表单验证失败");
      return;
    }

    setState(() => _isLoading = true);
    print("🔄 正在注册用户...");

    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      final user = await auth.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
        _role,
      );

      if (user != null && mounted) {
        print("✅ 注册成功，用户UID: ${user.id}");
        Navigator.pop(context);
      }
    } catch (e) {
      print("❌ 注册失败: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("注册失败: ${e.toString()}")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '邮箱'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return '请输入有效邮箱';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return '密码至少6位';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '姓名'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入姓名';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'teacher', child: Text('教师')),
                  DropdownMenuItem(value: 'admin', child: Text('管理员')),
                ],
                onChanged: (value) => setState(() => _role = value!),
                decoration: const InputDecoration(labelText: '角色'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}