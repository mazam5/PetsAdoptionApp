import 'package:flutter/material.dart';

class DarkModeService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<void> updateThemeMode(ThemeMode theme) async {}
}
