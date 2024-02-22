import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/components/dino/dino_component.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/entities/dino/dino_states.dart';
import 'package:game/src/utils/constants/assets_game.dart';

class DinoGame extends FlameGame {
  DinoGame({
    super.children,
    super.world,
    super.camera,
  });

  late DinoComponent _dinoComponent;
  late DinoModel _dinoModel;

  Vector2 get cameraVirtualSize => camera.viewport.virtualSize;

  @override
  Future<void> onLoad() async {
    _setScreenConfig();
    _loadGameAudios();
    _startGameLoopAudio();
    _loadGameImages();
    _setGameBackground();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void startGame() {
    _createDinoComponent();
    world.add(_dinoComponent);
  }

  void resetGame() {
    _dinoComponent.removeFromParent();
  }

  void _createDinoComponent() {
    final sprites = {
      DinoStates.idle: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
        texturePosition: Vector2(0, 0),
      ),
      DinoStates.run: SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
        texturePosition: Vector2((4) * 24, 0),
      ),
      DinoStates.kick: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
        texturePosition: Vector2((4 + 6) * 24, 0),
      ),
      DinoStates.hit: SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
        texturePosition: Vector2((4 + 6 + 4) * 24, 0),
      ),
      DinoStates.sprint: SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
        texturePosition: Vector2((4 + 6 + 4 + 3) * 24, 0),
      ),
    };
    _dinoModel = DinoModel(lives: 5);
    _dinoComponent = DinoComponent(
      spritesImage: images.fromCache(AssetsGame.imageDino),
      sprites: sprites,
      dinoModel: _dinoModel,
    );
  }

  Future<void> _setGameBackground() async {
    final images = [
      ParallaxImageData(AssetsGame.parallaxOne),
      ParallaxImageData(AssetsGame.parallaxTwo),
      ParallaxImageData(AssetsGame.parallaxThree),
      ParallaxImageData(AssetsGame.parallaxFour),
      ParallaxImageData(AssetsGame.parallaxFive),
      ParallaxImageData(AssetsGame.parallaxSix),
    ];
    final parallaxComponent = await loadParallaxComponent(
      images,
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    camera.backdrop.add(parallaxComponent);
  }

  Future<void> _setScreenConfig() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  void _setCameraAtCenterOfTheViewport() {
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;
  }

  Future<void> _loadGameAudios() async {
    final audioList = [
      AssetsGame.audioHurt,
      AssetsGame.audioJump,
      AssetsGame.audioLooper,
    ];

    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(audioList);
  }

  Future<void> _startGameLoopAudio() async {
    FlameAudio.bgm.play(AssetsGame.audioLooper, volume: 0.4);
  }

  Future<void> _loadGameImages() async {
    final imageList = [
      AssetsGame.imageAngryPig,
      AssetsGame.imageBat,
      AssetsGame.imageDino,
      AssetsGame.parallaxOne,
      AssetsGame.parallaxTwo,
      AssetsGame.parallaxThree,
      AssetsGame.parallaxFour,
      AssetsGame.parallaxFive,
      AssetsGame.parallaxSix,
      AssetsGame.imageRino,
    ];
    await images.loadAll(imageList);
    _setCameraAtCenterOfTheViewport();
  }
}
