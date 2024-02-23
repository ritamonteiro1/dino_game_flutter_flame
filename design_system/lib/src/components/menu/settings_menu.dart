import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onChangedFirstSwitch,
    required this.onChangedSecondSwitch,
    required this.onPressedIconBack,
  });

  final String firstText;
  final String secondText;
  final void Function(bool) onChangedFirstSwitch;
  final void Function(bool) onChangedSecondSwitch;
  final VoidCallback onPressedIconBack;

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  late bool isActiveFirstSwitch;
  late bool isActiveSecondSwitch;

  @override
  void initState() {
    super.initState();
    isActiveFirstSwitch = true;
    isActiveSecondSwitch = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.black.withAlpha(100),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchListTile(
                    title: Text(
                      widget.firstText,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    value: isActiveFirstSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        isActiveFirstSwitch = value;
                      });
                      widget.onChangedFirstSwitch.call(value);
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      widget.secondText,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    value: isActiveSecondSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        isActiveSecondSwitch = value;
                      });
                      widget.onChangedSecondSwitch.call(value);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onPressedIconBack.call();
                    },
                    child: const Icon(Icons.arrow_back_ios_rounded),
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
