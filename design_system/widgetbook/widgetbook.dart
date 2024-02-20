import 'package:design_system/src/components/main_menu.dart';
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
          ],
        ),
      ],
    );
  }
}
