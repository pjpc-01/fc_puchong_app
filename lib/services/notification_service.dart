// lib/services/notification_service.dart
class NotificationService {
  static Future<void> sendPushNotification({
    required String title,
    required String body,
    required List<String> recipientTokens,
  }) async {
    // 使用Firebase Cloud Messaging发送通知
  }

  static void setupInteractedMessage() {
    // 处理点击通知打开应用的情况
  }
}