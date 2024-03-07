import 'package:dependencies_src/dependencies_src.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:game/src/entities/dino/dino_model.dart';
import 'package:game/src/system/game/dino_game.dart';
import 'package:game/src/system/model/settings.dart';
import 'package:game/src/utils/constants/overlay_builder_ids.dart';
import 'package:game/src/utils/init_config/init_config.dart';
import 'package:localizations/localizations.dart';

Future<void> main() async {
  await InitConfig.execute();
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
        return ChangeNotifierProvider.value(
          value: game.dinoModel,
          child:
              Selector3<DinoModel, DinoModel, DinoModel, Tuple3<int, int, int>>(
                  selector: (
                    context,
                    dinoModelScore,
                    dinoModelLives,
                    dinoModelHigh,
                  ) =>
                      Tuple3(
                        dinoModelScore.currentScore,
                        dinoModelLives.lives,
                        dinoModelHigh.highScore,
                      ),
                  builder: (context, dinoModel, __) {
                    final score = dinoModel.item1;
                    final lives = dinoModel.item2;
                    final high = dinoModel.item3;
                    return Hud(
                      firstText: "${DinoGameStrings.of(context)!.score}$score",
                      secondText: "${DinoGameStrings.of(context)!.high}$high",
                      onPressedPauseIcon: () {
                        game.overlays.remove(OverLayBuilderIds.hud);
                        game.overlays.add(OverLayBuilderIds.pauseMenu);
                        game.pauseEngine();
                        game.pauseGameAudio();
                      },
                      lives: lives,
                    );
                  }),
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
        return ChangeNotifierProvider.value(
          value: game.dinoModel,
          child: Selector<DinoModel, int>(
            selector: (context, dinoModel) => dinoModel.currentScore,
            builder: (context, score, __) {
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
                  game.overlays.add(OverLayBuilderIds.mainMenu);
                  game.resumeEngine();
                  game.resetGame();
                  game.resumeGameAudio();
                },
              );
            },
          ),
        );
      },
      OverLayBuilderIds.settingsMenu: (BuildContext context, DinoGame game) {
        return ChangeNotifierProvider.value(
          value: game.settings,
          child: Selector2<Settings, Settings, Tuple2<bool, bool>>(
              selector: (context, settingsMusic, settingsEffects) => Tuple2(
                    settingsMusic.isEnabledBmg,
                    settingsEffects.isEnabledSfx,
                  ),
              builder: (context, settings, __) {
                final isActiveGameAudio = settings.item1;
                final isActiveGameEffect = settings.item2;
                return SettingsMenu(
                  isActiveFirstSwitch: isActiveGameAudio,
                  isActiveSecondSwitch: isActiveGameEffect,
                  firstText: DinoGameStrings.of(context)!.music,
                  secondText: DinoGameStrings.of(context)!.effects,
                  onChangedFirstSwitch: (bool isEnabled) {
                    Provider.of<Settings>(context, listen: false).isEnabledBmg =
                        isEnabled;
                    if (isEnabled) {
                      game.startGameAudio();
                    } else {
                      game.stopGameAudio();
                    }
                  },
                  onChangedSecondSwitch: (bool isEnabled) {
                    Provider.of<Settings>(context, listen: false).isEnabledSfx =
                        isEnabled;
                  },
                  onPressedIconBack: () {
                    game.overlays.remove(OverLayBuilderIds.settingsMenu);
                    game.overlays.add(OverLayBuilderIds.mainMenu);
                  },
                );
              }),
        );
      },
      OverLayBuilderIds.gameOverMenu: (BuildContext context, DinoGame game) {
        return ChangeNotifierProvider.value(
          value: game.dinoModel,
          child: Selector<DinoModel, int>(
              selector: (context, dinoModel) => dinoModel.currentScore,
              builder: (context, score, __) {
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
              }),
        );
      },
    };
  }
}
