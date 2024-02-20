// ignore_for_file: avoid_print

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: "AdvancedBasicMoneyTracker V2",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("AdvancedBasicMoneyTracker V2"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(children: [
          const SizedBox(height: 25),
          _TitleBox(),
          //
          _DisplayBox(),
          //
          InputBox(),
          //
          Container(
            color: Colors.amber,
            height: 50,
          ),
          const SizedBox(height: 50),
        ]),
      );
    });
  }
}

class MyAppState extends ChangeNotifier {
  double currentSpend = 0;
  int currentWeek = 0;

  void getCurrentSpend() {
    //Thing
    notifyListeners();
  }

  void updateCurrentSpend(double amount) {
    currentSpend += amount;
    notifyListeners();
  }

  int getCurrentWeek() {
    //Thing
    return currentWeek;
  }
}

class _TitleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text("Advanced Really Basic Money Tracker",
                style: TextStyle(
                  fontSize: 25,
                )),
            SizedBox(height: 10),
            Text("By Me."),
          ],
        ),
      ),
    );
  }
}

class _DisplayBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentSpend = appState.currentSpend.toString();
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total This Week: "),
              Text("\$" + currentSpend),
            ],
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {},
              child: Text("Poot!"),
            ),
          ),
        ]),
      ),
    );
  }
}

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
