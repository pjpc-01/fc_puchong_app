import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afterschool_center/services/auth_service.dart';
import 'package:afterschool_center/views/auth/login_screen.dart';
import 'package:afterschool_center/views/auth/register_screen.dart';
import 'package:afterschool_center/views/admin/admin_home.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeworkRepository {
  final FirebaseFirestore _firestore;

  Future<void> assignHomework(Homework homework) async {
    await _firestore.collection('homeworks').add(homework.toMap());
  }

  Stream<List<Homework>> getClassHomework(String classId) {
    return _firestore
        .collection('homeworks')
        .where('classId', isEqualTo: classId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Homework.fromMap(doc.data())).toList());
  }
}