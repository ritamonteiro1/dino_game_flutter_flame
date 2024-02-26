import 'dart:math';

import 'package:dependencies_src/dependencies_src.dart';
import 'package:game/src/components/enemy/enemy_component.dart';
import 'package:game/src/entities/enemy/enemy_model.dart';
import 'package:game/src/system/dino_game.dart';
import 'package:game/src/utils/constants/assets_game.dart';

class EnemyListComponent extends Component with HasGameReference<DinoGame> {
  EnemyListComponent() {
    _spawnNextEnemyTimer.onTick = () {
      _addRandomEnemyComponentToWorld.call();
    };
  }

  final List<EnemyModel> _enemyListModel = [];
  final _spawnNextEnemyTimer = Timer(2, repeat: true);

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }
    _createEnemyListModel();
    _spawnNextEnemyTimer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _spawnNextEnemyTimer.update(dt);
    super.update(dt);
  }

  void removeEnemyListFromParent() {
    final enemyList = game.world.children.whereType<EnemyComponent>();
    for (var enemy in enemyList) {
      enemy.removeFromParent();
    }
  }

  void _addRandomEnemyComponentToWorld() {
    final random = Random();
    final randomIndexOfEnemyListModel = random.nextInt(_enemyListModel.length);
    final enemyModel = _enemyListModel.elementAt(randomIndexOfEnemyListModel);
    final enemyComponent = EnemyComponent(enemyModel: enemyModel);

    enemyComponent.anchor = Anchor.bottomLeft;
    enemyComponent.position = Vector2(
      game.cameraVirtualSize.x + 32,
      game.cameraVirtualSize.y - 24,
    );

    if (enemyModel.canFly) {
      final newHeight = random.nextDouble() * 2 * enemyModel.textureSize.y;
      enemyComponent.position.y -= newHeight;
    }

    enemyComponent.size = enemyModel.textureSize;

    game.world.add(enemyComponent);
  }

  void _createEnemyListModel() {
    if (_enemyListModel.isEmpty) {
      _enemyListModel.addAll([
        EnemyModel(
          image: game.images.fromCache(AssetsGame.imageAngryPig),
          amountOfFrames: 16,
          stepTime: 0.1,
          textureSize: Vector2(36, 30),
          speedX: 80,
          canFly: false,
        ),
        EnemyModel(
          image: game.images.fromCache(AssetsGame.imageBat),
          amountOfFrames: 7,
          stepTime: 0.1,
          textureSize: Vector2(46, 30),
          speedX: 100,
          canFly: true,
        ),
        EnemyModel(
          image: game.images.fromCache(AssetsGame.imageRino),
          amountOfFrames: 6,
          stepTime: 0.09,
          textureSize: Vector2(52, 34),
          speedX: 150,
          canFly: false,
        ),
      ]);
    }
  }
}
