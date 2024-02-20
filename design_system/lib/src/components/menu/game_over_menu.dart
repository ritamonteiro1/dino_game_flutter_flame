import 'dart:ui';

import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textFirstButton,
    required this.textSecondButton,
    required this.onPressedFirstButton,
    required this.onPressedSecondButton,
  });

  final String title;
  final String subtitle;
  final String textFirstButton;
  final String textSecondButton;
  final VoidCallback onPressedFirstButton;
  final VoidCallback onPressedSecondButton;

  static const id = 'GameOverMenu';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  ElevatedButton(
                    child: Text(
                      textFirstButton,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      onPressedFirstButton.call();
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      textSecondButton,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      onPressedSecondButton.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
