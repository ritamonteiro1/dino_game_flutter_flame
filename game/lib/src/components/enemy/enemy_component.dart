import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/enemy/enemy_model.dart';
import 'package:game/src/system/dino_game.dart';

class EnemyComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<DinoGame> {
  EnemyComponent({
    required this.sprite,
    required this.enemyModel,
  }) {
    animation = sprite;
  }

  final SpriteAnimation sprite;
  final EnemyModel enemyModel;
}
