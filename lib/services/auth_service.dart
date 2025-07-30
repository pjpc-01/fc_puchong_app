import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afterschool_center/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 修改为统一的异步方法
  Future<UserModel?> _userFromFirebase(User? user) async {
    if (user == null) return null;

    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return UserModel(
            id: user.uid,
            email: user.email ?? '',
            name: data['name'] ?? '',
            role: data['role'] ?? 'teacher'
        );
      }
      return null;
    } catch (e) {
      print('获取用户数据错误: $e');
      return null;
    }
  }

  // 用户状态流
  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap(_userFromFirebase);
  }

  // 统一方法名为 signInWithEmail（或保持为 loginWithEmail，但要统一）
  // 将 signInWithEmail 改为 loginWithEmail
  Future<UserModel?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      print('登录错误: ${e.code} - ${e.message}');
      return null;
    }
  }

  // 注册方法
  Future<UserModel?> register(String email, String password, String name, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ 用户创建成功，UID: ${result.user?.uid}");
      return await _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      print("❌ 注册失败: ${e.code} - ${e.message}");
      rethrow; // 重新抛出错误，让 UI 层处理
    }
  }

  // 登出方法
  Future<void> signOut() async {
    await _auth.signOut();
  }
}