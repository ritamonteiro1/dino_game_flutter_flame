import 'package:dependencies_src/dependencies_src.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:game/src/system/dino_game.dart';
import 'package:game/src/utils/constants/overlay_builder_ids.dart';
import 'package:localizations/localizations.dart';

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
      onGenerateTitle: (context) => DinoGameStrings.of(context)!.appName,
      localizationsDelegates: DinoGameStrings.localizationsDelegates,
      supportedLocales: DinoGameStrings.supportedLocales,
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
        const score = "20";
        const high = "22";
        return Hud(
          firstText: "${DinoGameStrings.of(context)!.score}$score",
          secondText: "${DinoGameStrings.of(context)!.score}$high",
          onPressedPauseIcon: () {
            game.overlays.remove(OverLayBuilderIds.hud);
            game.overlays.add(OverLayBuilderIds.pauseMenu);
            game.pauseEngine();
            game.pauseGameAudio();
          },
          lives: 4,
        );
      },
      OverLayBuilderIds.mainMenu: (BuildContext context, DinoGame game) {
        return MainMenu(
          title: DinoGameStrings.of(context)!.appName,
          textFirstButton: DinoGameStrings.of(context)!.play,
          textSecondButton: DinoGameStrings.of(context)!.settings,
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
        const score = "100";
        return PauseMenu(
          title: "${DinoGameStrings.of(context)!.score}$score",
          textFirstButton: DinoGameStrings.of(context)!.resume,
          textSecondButton: DinoGameStrings.of(context)!.restart,
          textThirdButton: DinoGameStrings.of(context)!.exit,
          onPressedFirstButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resumeGameAudio();
          },
          onPressedSecondButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            game.startGame();
            game.resumeGameAudio();
          },
          onPressedThirdButton: () {
            game.overlays.remove(OverLayBuilderIds.pauseMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            game.resumeGameAudio();
          },
        );
      },
      OverLayBuilderIds.settingsMenu: (BuildContext context, DinoGame game) {
        return SettingsMenu(
          firstText: DinoGameStrings.of(context)!.music,
          secondText: DinoGameStrings.of(context)!.effects,
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
        const score = "20";
        return GameOverMenu(
          title: DinoGameStrings.of(context)!.gameOver,
          subtitle: "${DinoGameStrings.of(context)!.yourScore}$score",
          textFirstButton: DinoGameStrings.of(context)!.restart,
          textSecondButton: DinoGameStrings.of(context)!.exit,
          onPressedFirstButton: () {
            game.overlays.remove(OverLayBuilderIds.gameOverMenu);
            game.overlays.add(OverLayBuilderIds.hud);
            game.resumeEngine();
            game.resetGame();
            game.startGame();
            game.resumeGameAudio();
          },
          onPressedSecondButton: () {
            game.overlays.remove(OverLayBuilderIds.gameOverMenu);
            game.overlays.add(OverLayBuilderIds.mainMenu);
            game.resumeEngine();
            game.resetGame();
            game.resumeGameAudio();
          },
        );
      },
    };
  }
}
