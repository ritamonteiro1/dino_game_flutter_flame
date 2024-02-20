import 'package:flutter/material.dart';

class LoadingGame extends StatelessWidget {
  const LoadingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 200,
        child: LinearProgressIndicator(),
      ),
    );
  }
}
