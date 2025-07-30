import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:afterschool_center/main.dart';

void main() {
  testWidgets('登录页面渲染测试', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('登录'), findsOneWidget);
    expect(find.byType(TextField), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
