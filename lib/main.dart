import 'package:banking/src/data/notifications/notification_api.dart';
import 'package:banking/src/internal/application.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  NotificationService().requestIOSPermissions;
  runApp(const Application());
}
