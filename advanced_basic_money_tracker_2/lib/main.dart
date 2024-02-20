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
          _TitleBox(),
          const SizedBox(height: 50),
          Container(
            color: Colors.amber,
            height: 50,
          ),
          const SizedBox(height: 50),
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

class MyAppState extends ChangeNotifier {}

class _TitleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(50.0),
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
