import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/enemy/enemy_model.dart';
import 'package:game/src/system/dino_game.dart';

class EnemyComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<DinoGame> {
  EnemyComponent({
    required this.enemyModel,
  }) {
    animation = SpriteAnimation.fromFrameData(
      enemyModel.image,
      SpriteAnimationData.sequenced(
        amount: enemyModel.amountOfFrames,
        stepTime: enemyModel.stepTime,
        textureSize: enemyModel.textureSize,
      ),
    );
  }

  final EnemyModel enemyModel;

  @override
  void onMount() {
    size *= 0.6;
    _addHitBox();
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= enemyModel.speedX * dt;

    final itPassedByDinoComponent = position.x < -enemyModel.textureSize.x;
    if (itPassedByDinoComponent) {
      removeFromParent();
      game.dinoModel.currentScore += 1;
    }

    super.update(dt);
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
