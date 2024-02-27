import 'package:dependencies_src/dependencies_src.dart';
import 'package:flutter/foundation.dart';

part 'dino_model.g.dart';

@HiveType(typeId: 0)
class DinoModel extends ChangeNotifier with HiveObjectMixin {
  @HiveField(1)
  int _highScore = 0;
  int _currentScore = 0;
  int _lives = 5;

  int get highScore => _highScore;

  int get currentScore => _currentScore;

  int get lives => _lives;

  set lives(int value) {
    if (value >= 0 && value <= 5) {
      _lives = value;
      notifyListeners();
    }
  }

  set currentScore(int value) {
    _currentScore = value;
    if (highScore < _currentScore) {
      _highScore = _currentScore;
    }
    notifyListeners();
    save();
  }
}
