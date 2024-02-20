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
          ],
        ),
      ],
    );
  }
}
