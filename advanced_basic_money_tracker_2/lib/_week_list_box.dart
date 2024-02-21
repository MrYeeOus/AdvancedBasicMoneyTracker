// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class WeekListBox extends StatefulWidget {
  const WeekListBox({super.key});

  @override
  State<WeekListBox> createState() => _WeekListBoxState();
}

class _WeekListBoxState extends State<WeekListBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(padding: const EdgeInsets.all(8), children: [
        for (var i = 0; i < 52; i++)
          Container(
            height: 50,
            child: Row(
              children: [
                Text("Week ${i + 1}:"),
              ],
            ),
          ),
      ]),
    );
  }
}
