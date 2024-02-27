import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/dino/dino_model.dart';

abstract class DinoGameService {
  static Future<DinoModel> getDinoModelFromCache() async {
    final box = await Hive.openBox<DinoModel>(_boxName);
    final playerData = box.get(_boxName);
    if (playerData == null) {
      await box.put(_boxName, DinoModel());
    }
    return box.get(_boxName)!;
  }

  static const _boxName = 'DinoGameCache';
}
