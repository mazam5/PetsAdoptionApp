import 'package:flutter/material.dart';

import 'widgets/app.dart';
import 'src/darkmode/darkmode_controller.dart';
import 'src/darkmode/darkmode_service.dart';

void main() async {
  final themeController = DarkModeController(DarkModeService());
  await themeController.loadSettings();
  runApp(MyApp(themeController: themeController));
}
