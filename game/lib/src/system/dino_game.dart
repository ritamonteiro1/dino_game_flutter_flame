import 'package:dependencies_src/dependencies_src.dart';
import 'package:flutter/material.dart';
import 'package:game/src/components/dino/dino_component.dart';
import 'package:game/src/components/enemy/enemy_list_component.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/entities/dino/dino_states.dart';
import 'package:game/src/utils/constants/assets_game.dart';
import 'package:game/src/utils/constants/overlay_builder_ids.dart';

class DinoGame extends FlameGame with TapDetector {
  DinoGame({
    super.children,
    super.world,
    super.camera,
  });

  late DinoComponent _dinoComponent;
  late EnemyListComponent _enemyListComponent;

  late DinoModel dinoModel;

  bool isEnabledJumpAndHurtEffects = true;

  Vector2 get cameraVirtualSize => camera.viewport.virtualSize;

  @override
  Future<void> onLoad() async {
    _setScreenConfig();
    _loadGameAudios();
    startGameAudio();
    _loadGameImages();
    _setGameBackground();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final dinoHasNoLives = dinoModel.lives <= 0;
    if (dinoHasNoLives) {
      overlays.add(OverLayBuilderIds.gameOverMenu);
      overlays.remove(OverLayBuilderIds.hud);
      pauseEngine();
      FlameAudio.bgm.pause();
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(OverLayBuilderIds.hud)) {
      _dinoComponent.jump();
    }
    super.onTapDown(info);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(overlays.isActive(OverLayBuilderIds.pauseMenu)) &&
            !(overlays.isActive(OverLayBuilderIds.gameOverMenu))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        if (overlays.isActive(OverLayBuilderIds.hud)) {
          overlays.remove(OverLayBuilderIds.hud);
          overlays.add(OverLayBuilderIds.pauseMenu);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }

  void startGame() {
    _createDinoComponent();
    _createEnemyListComponent();
    world.add(_dinoComponent);
    world.add(_enemyListComponent);
  }

  void resetGame() {
    _removeComponentsFromParent();
    dinoModel.lives = 5;
    dinoModel.currentScore = 0;
  }

  void _removeComponentsFromParent() {
    _dinoComponent.removeFromParent();
    _enemyListComponent.removeEnemyListFromParent();
    _enemyListComponent.removeFromParent();
  }

  void _createDinoComponent() {
    final sprites = _getDinoSprites();
    dinoModel = DinoModel();
    _dinoComponent = DinoComponent(
      spritesImage: images.fromCache(AssetsGame.imageDino),
      sprites: sprites,
      dinoModel: dinoModel,
    );
  }

  void _createEnemyListComponent() {
    _enemyListComponent = EnemyListComponent();
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

  void disableGameEffects() {
    isEnabledJumpAndHurtEffects = false;
  }

  void enableGameEffects() {
    isEnabledJumpAndHurtEffects = true;
  }

  void resumeGameAudio() {
    FlameAudio.bgm.resume();
  }

  void pauseGameAudio() {
    FlameAudio.bgm.pause();
  }

  void startGameAudio() {
    FlameAudio.bgm.play(AssetsGame.audioLooper, volume: 0.4);
  }

  void stopGameAudio() {
    FlameAudio.bgm.stop();
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

  Map<DinoStates, SpriteAnimationData> _getDinoSprites() {
    return {
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
  }
}
