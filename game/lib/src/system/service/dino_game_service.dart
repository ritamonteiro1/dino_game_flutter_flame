import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/system/model/settings.dart';

abstract class DinoGameService {
  static Future<DinoModel> getDinoModelFromCache() async {
    final box = await Hive.openBox<DinoModel>(_dinoBoxName);
    final dino = box.get(_dinoBoxName);
    if (dino == null) {
      await box.put(_dinoBoxName, DinoModel());
    }
    return box.get(_dinoBoxName)!;
  }

  static Future<Settings> getSettingsFromCache() async {
    final box = await Hive.openBox<Settings>(_settingsBoxName);
    final settings = box.get(_settingsBoxName);

    if (settings == null) {
      await box.put(_settingsBoxName, Settings(bgm: true, sfx: true));
    }
    return box.get(_settingsBoxName)!;
  }

  static const _dinoBoxName = 'DinoGameCache';
  static const _settingsBoxName = 'SettingsCache';
}
