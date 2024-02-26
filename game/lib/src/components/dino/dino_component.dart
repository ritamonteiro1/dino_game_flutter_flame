import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/components/enemy/enemy_list_component.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/entities/dino/dino_states.dart';
import 'package:game/src/system/dino_game.dart';
import 'package:game/src/utils/constants/assets_game.dart';

class DinoComponent extends SpriteAnimationGroupComponent<DinoStates>
    with CollisionCallbacks, HasGameReference<DinoGame> {
  DinoComponent({
    required this.spritesImage,
    required this.sprites,
    required this.dinoModel,
  }) : super.fromFrameData(spritesImage, sprites);

  final Image spritesImage;
  final Map<DinoStates, SpriteAnimationData> sprites;
  final DinoModel dinoModel;

  static const _gravity = 800.00;
  final _animationsTimer = Timer(1);

  double _yMax = 0.00;
  double _speedY = 0.00;
  bool _isHit = false;

  @override
  void onMount() {
    _setFirstStatus();
    _addHitBox();
    _yMax = y;
    _setCallbackForAnimationsTimer();
    super.onMount();
  }

  @override
  void update(double dt) {
    _speedY += _gravity * dt;
    y += _speedY * dt;

    if (_isOnGround()) {
      y = _yMax;
      _speedY = 0.00;
      if (current != DinoStates.hit && current != DinoStates.run) {
        current = DinoStates.run;
      }
    }

    _animationsTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is EnemyListComponent) && (!_isHit)) {
      _hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void jump() {
    if (_isOnGround()) {
      _speedY = -300;
      current = DinoStates.idle;
      _playJumpAudio();
    }
  }

  void _hit() {
    _isHit = true;
    _playHurtAudio();
    current = DinoStates.hit;
    _animationsTimer.start();
    dinoModel.lives -= 1;
  }

  void _setCallbackForAnimationsTimer() {
    _animationsTimer.onTick = () {
      current = DinoStates.run;
      _isHit = false;
    };
  }

  void _setFirstStatus() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, game.cameraVirtualSize.y - 22);
    size = Vector2.all(24);
    current = DinoStates.run;
    _isHit = false;
    _speedY = 0.00;
  }

  bool _isOnGround() {
    return y >= _yMax;
  }

  void _addHitBox() {
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
  }

  void _playJumpAudio() {
    FlameAudio.play(AssetsGame.audioJump);
  }

  void _playHurtAudio() {
    FlameAudio.play(AssetsGame.audioHurt);
  }
}
