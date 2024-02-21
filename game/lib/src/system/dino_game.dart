import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/utils/assets_game.dart';

class DinoGame extends FlameGame {
  DinoGame({
    super.children,
    super.world,
    super.camera,
  });

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
