import 'package:dependencies_src/dependencies_src.dart';
import 'package:flutter/foundation.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends ChangeNotifier with HiveObjectMixin {
  Settings({
    bool bgm = false,
    bool sfx = false,
  }) {
    _bgm = bgm;
    _sfx = sfx;
  }

  @HiveField(0)
  bool _bgm = false;
  @HiveField(1)
  bool _sfx = false;

  bool get isEnabledBmg => _bgm;

  bool get isEnabledSfx => _sfx;

  set isEnabledBmg(bool value) {
    _bgm = value;
    notifyListeners();
    save();
  }

  set isEnabledSfx(bool value) {
    _sfx = value;
    notifyListeners();
    save();
  }
}
