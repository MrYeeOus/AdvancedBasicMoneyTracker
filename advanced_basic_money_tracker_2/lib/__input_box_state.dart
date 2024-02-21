// ignore_for_file: avoid_print

import 'package:advanced_basic_money_tracker_2/main.dart';
import 'package:advanced_basic_money_tracker_2/_csvStuff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var csvState = context.watch<CSVState>();
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Text("New Purchase:"),
            //Text("How Much: "),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("How Much: "),
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "\$\$\$",
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //Process data
                          print(textController.text);
                          appState.updateCurrentSpend(
                              double.tryParse(textController.text) ?? 0.0);
                          csvState.updateCSVListData(0, 10.0);
                          textController.clear();
                        }
                      },
                      child: const Text("Ya Go"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
