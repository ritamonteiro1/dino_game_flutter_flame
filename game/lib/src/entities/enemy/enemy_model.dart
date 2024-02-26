import 'package:dependencies_src/dependencies_src.dart';

class EnemyModel {
  final Image image;
  final int amountOfFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final bool canFly;

  const EnemyModel({
    required this.image,
    required this.amountOfFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.canFly,
  });
}
