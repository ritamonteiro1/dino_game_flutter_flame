import 'package:dependencies_src/dependencies_src.dart';
import 'package:flutter/material.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/system/model/settings.dart';

abstract class InitConfig {
  static Future<void> execute() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initHive();
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<DinoModel>(DinoModelAdapter());
    Hive.registerAdapter<Settings>(SettingsAdapter());
  }
}
