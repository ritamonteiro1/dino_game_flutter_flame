import 'dart:ui';

import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({
    super.key,
    required this.title,
    required this.textFirstButton,
    required this.textSecondButton,
    required this.textThirdButton,
    required this.onPressedFirstButton,
    required this.onPressedSecondButton,
    required this.onPressedThirdButton,
  });

  final String title;
  final String textFirstButton;
  final String textSecondButton;
  final String textThirdButton;
  final VoidCallback onPressedFirstButton;
  final VoidCallback onPressedSecondButton;
  final VoidCallback onPressedThirdButton;

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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onPressedFirstButton.call();
                    },
                    child: Text(
                      textFirstButton,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onPressedSecondButton.call();
                    },
                    child: Text(
                      textSecondButton,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onPressedThirdButton.call();
                    },
                    child: Text(
                      textThirdButton,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
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
