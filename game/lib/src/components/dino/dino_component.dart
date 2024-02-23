import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/entities/dino/dino_states.dart';
import 'package:game/src/system/dino_game.dart';
import 'package:game/src/utils/constants/assets_game.dart';

class DinoComponent extends SpriteAnimationGroupComponent<DinoStates>
    with HasGameReference<DinoGame> {
  DinoComponent({
    required this.spritesImage,
    required this.sprites,
    required this.dinoModel,
  }) : super.fromFrameData(spritesImage, sprites);

  final Image spritesImage;
  final Map<DinoStates, SpriteAnimationData> sprites;
  final DinoModel dinoModel;

  @override
  void onMount() {
    _setFirstStatus();
    _addHitBox();
    super.onMount();
  }

  void jump() {
    current = DinoStates.idle;
    _playJumpAudio();
  }

  void _setFirstStatus() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, game.cameraVirtualSize.y - 22);
    size = Vector2.all(24);
    current = DinoStates.run;
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

  void playJumpAudio() {
    FlameAudio.play(AssetsGame.audioHurt);
  }
}
