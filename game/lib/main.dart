import 'package:dependencies_src/dependencies_src.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:game/src/system/dino_game.dart';
import 'package:game/src/utils/constants/overlay_builder_ids.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DinoApp());
}

class DinoApp extends StatelessWidget {
  const DinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dino Game",
      home: Scaffold(
        body: GameWidget<DinoGame>.controlled(
          gameFactory: () {
            return DinoGame(
              camera: CameraComponent.withFixedResolution(
                width: 360,
                height: 180,
              ),
            );
          },
          loadingBuilder: (_) {
            return const LoadingGame();
          },
          initialActiveOverlays: const [OverLayBuilderIds.mainMenu],
          overlayBuilderMap: _overlayBuilderWidgets(),
        ),
      ),
    );
  }

  Map<String, OverlayWidgetBuilder<DinoGame>> _overlayBuilderWidgets() {
    return {
      OverLayBuilderIds.hud: (BuildContext context, DinoGame game) {
        return Hud(
          firstText: "Score: 20",
          secondText: "High: 22",
          onPressedPauseIcon: () {
            game.overlays.remove(OverLayBuilderIds.hud);
            game.overlays.add(OverLayBuilderIds.pauseMenu);
            game.pauseEngine();
            FlameAudio.bgm.pause();
          },
          lives: 4,
        );
      },
      OverLayBuilderIds.mainMenu: (BuildContext context, DinoGame game) {
        return MainMenu(
          title: "Dino Game",
          textFirstButton: "Jogar",
          textSecondButton: "Configurações",
          onPressedFirstButton: () {
            game.overlays.remove(OverLayBuilderIds.mainMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.startGame();
          },
          onPressedSecondButton: () {
            game.overlays.remove(OverLayBuilderIds.mainMenu);
            game.overlays.add(OverLayBuilderIds.settingsMenu);
          },
        );
      },
      OverLayBuilderIds.pauseMenu: (BuildContext context, DinoGame game) {
        return PauseMenu(
          title: "Score: 100",
          textFirstButton: "Resume",
          textSecondButton: "Restart",
          textThirdButton: "Exit",
          onPressedFirstButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            FlameAudio.bgm.resume();
          },
          onPressedSecondButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            game.startGame();
            FlameAudio.bgm.resume();
          },
          onPressedThirdButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            FlameAudio.bgm.resume();
          },
        );
      },
      OverLayBuilderIds.settingsMenu: (BuildContext context, DinoGame game) {
        return SettingsMenu(
          firstText: "Music",
          secondText: "Effects",
          isActiveFirstSwitch: true,
          isActiveSecondSwitch: false,
          onChangedFirstSwitch: (bool value) {},
          onChangedSecondSwitch: (bool value) {},
          onPressedIconBack: () {
            game.overlays.remove(OverLayBuilderIds.settingsMenu);
            game.overlays.add(OverLayBuilderIds.mainMenu);
          },
        );
      },
      OverLayBuilderIds.gameOverMenu: (BuildContext context, DinoGame game) {
        return GameOverMenu(
          title: "Game Over",
          subtitle: "Seu Score: 20",
          textFirstButton: "Restart",
          textSecondButton: "Exit",
          onPressedFirstButton: () {
            game.overlays.remove(OverLayBuilderIds.gameOverMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            game.startGame();
            FlameAudio.bgm.resume();
          },
          onPressedSecondButton: () {
            game.overlays.remove(OverLayBuilderIds.gameOverMenu);
            game.overlays.add(OverLayBuilderIds.mainMenu);
            game.resumeEngine();
            game.resetGame();
            FlameAudio.bgm.resume();
          },
        );
      },
    };
  }
}
