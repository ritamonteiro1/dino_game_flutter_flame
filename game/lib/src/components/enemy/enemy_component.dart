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

  @override
  void onMount() {
    size *= 0.6;
    _addHitBox();
    super.onMount();
  }

  void _addHitBox() {
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2) / 2,
      ),
    );
  }
}
