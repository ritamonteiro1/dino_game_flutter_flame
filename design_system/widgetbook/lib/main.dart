import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetBookDinoGame());
}

class WidgetBookDinoGame extends StatelessWidget {
  const WidgetBookDinoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookComponent(
          name: "Menus",
          useCases: [
            WidgetbookUseCase(
              name: "Main",
              builder: (context) {
                return Container(
                  color: Colors.grey,
                  child: MainMenu(
                    title: "Dino Game",
                    textFirstButton: "Jogar",
                    textSecondButton: "Configurações",
                    onPressedFirstButton: () {},
                    onPressedSecondButton: () {},
                  ),
                );
              },
            ),
            WidgetbookUseCase(
              name: "Pause",
              builder: (context) {
                return Container(
                  color: Colors.grey,
                  child: PauseMenu(
                    title: "Score: 100",
                    textFirstButton: "Resume",
                    textSecondButton: "Restart",
                    textThirdButton: "Exit",
                    onPressedFirstButton: () {},
                    onPressedSecondButton: () {},
                    onPressedThirdButton: () {},
                  ),
                );
              },
            ),
            WidgetbookUseCase(
              name: "Settings",
              builder: (context) {
                return Container(
                  color: Colors.grey,
                  child: SettingsMenu(
                    firstText: "Music",
                    secondText: "Effects",
                    isActiveFirstSwitch: true,
                    isActiveSecondSwitch: false,
                    onChangedFirstSwitch: (bool value) {},
                    onChangedSecondSwitch: (bool value) {},
                    onPressedIconBack: () {},
                  ),
                );
              },
            ),
            WidgetbookUseCase(
              name: "Game Over",
              builder: (context) {
                return Container(
                  color: Colors.grey,
                  child: GameOverMenu(
                    title: "Game Over",
                    subtitle: "Seu Score: 20",
                    textFirstButton: "Restart",
                    textSecondButton: "Exit",
                    onPressedFirstButton: () {},
                    onPressedSecondButton: () {},
                  ),
                );
              },
            ),
          ],
        ),
        WidgetbookComponent(
          name: "Others",
          useCases: [
            WidgetbookUseCase(
              name: "Hud",
              builder: (context) {
                return Container(
                  color: Colors.black,
                  child: Hud(
                    firstText: "Score: 20",
                    secondText: "High: 22",
                    onPressedPauseIcon: () {},
                    lives: 4,
                  ),
                );
              },
            ),
            WidgetbookUseCase(
              name: "Loading",
              builder: (context) {
                return Container(
                  color: Colors.black,
                  child: const LoadingGame(),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
