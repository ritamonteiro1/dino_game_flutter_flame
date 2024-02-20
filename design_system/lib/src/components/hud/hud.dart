import 'package:flutter/material.dart';

class Hud extends StatelessWidget {
  const Hud({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onPressedPauseIcon,
    required this.lives,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onPressedPauseIcon;
  final int lives;

  static const id = 'Hud';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                firstText,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                secondText,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              onPressedPauseIcon.call();
            },
            child: const Icon(Icons.pause, color: Colors.white),
          ),
          Row(
            children: List.generate(
              _maxNumberOfLives,
              (index) {
                return (index < lives)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

const _maxNumberOfLives = 5;
