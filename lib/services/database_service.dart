import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afterschool_center/models/user_model.dart';
import 'package:afterschool_center/models/class_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 添加班级
  Future<void> addClass(ClassModel classModel) async {
    await _firestore.collection('classes').doc(classModel.id).set(classModel.toMap());
  }

  // 获取所有班级
  Stream<List<ClassModel>> getClasses() {
    return _firestore.collection('classes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ClassModel.fromMap(doc.data())).toList();
    });
  }

  // 获取特定班级
  Future<ClassModel?> getClass(String classId) async {
    DocumentSnapshot doc = await _firestore.collection('classes').doc(classId).get();
    return doc.exists ? ClassModel.fromMap(doc.data() as Map<String, dynamic>) : null;
  }

  // 更新用户信息
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // 获取所有老师
  Stream<List<UserModel>> getTeachers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'teacher')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  // 获取特定用户
  Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? UserModel.fromMap(doc.data() as Map<String, dynamic>) : null;
  }
}