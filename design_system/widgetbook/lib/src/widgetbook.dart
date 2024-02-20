import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

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
                return MainMenu(
                  title: "Dino Game",
                  textFirstButton: "Jogar",
                  textSecondButton: "Configurações",
                  onPressedFirstButton: () {},
                  onPressedSecondButton: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: "Pause",
              builder: (context) {
                return PauseMenu(
                  title: "Score: 100",
                  textFirstButton: "Resume",
                  textSecondButton: "Restart",
                  textThirdButton: "Exit",
                  onPressedFirstButton: () {},
                  onPressedSecondButton: () {},
                  onPressedThirdButton: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: "Settings",
              builder: (context) {
                return SettingsMenu(
                  firstText: "Music",
                  secondText: "Effects",
                  isActiveFirstSwitch: true,
                  isActiveSecondSwitch: false,
                  onChangedFirstSwitch: (bool value) {},
                  onChangedSecondSwitch: (bool value) {},
                  onPressedIconBack: () {},
                );
              },
            ),
            WidgetbookUseCase(
              name: "Game Over",
              builder: (context) {
                return GameOverMenu(
                  title: "Game Over",
                  subtitle: "Seu Score: 20",
                  textFirstButton: "Restart",
                  textSecondButton: "Exit",
                  onPressedFirstButton: () {},
                  onPressedSecondButton: () {},
                );
              },
            ),
          ],
        ),
        WidgetbookComponent(
          name: "Hud",
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
          ],
        )
      ],
    );
  }
}
