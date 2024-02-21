import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/entities/dino/dino_states.dart';
import 'package:game/src/system/dino_game.dart';

class DinoComponent extends SpriteAnimationGroupComponent<DinoStates>
    with HasGameReference<DinoGame> {
  DinoComponent({
    required this.spritesImage,
    required this.sprites,
  }) : super.fromFrameData(spritesImage, sprites);

  final Image spritesImage;
  final Map<DinoStates, SpriteAnimationData> sprites;
}
