// ignore_for_file: avoid_print

import 'package:advanced_basic_money_tracker_2/__input_box_state.dart';
import 'package:advanced_basic_money_tracker_2/_loadingScreen.dart';
import 'package:advanced_basic_money_tracker_2/_week_list_box.dart';
import 'package:advanced_basic_money_tracker_2/_csvStuff.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  double _currentSpend = 0;
  double get currentSpend => _currentSpend;

  //30Apr25
  double _currentAmount = 0;
  double get currentAmount => _currentAmount;
  void setCurrentAmount(double amount)  {
    _currentAmount = amount;
  }

  int currentWeek = 0;

  void updateCurrentSpend(double amount) {
    _currentSpend += amount;
    notifyListeners();
  }

  void setCurrentSpend(double amount) {
    _currentSpend = amount;
    notifyListeners();
  }

  int getCurrentWeek() {
    //Thing
    return currentWeek;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => CSVState()),
      ],
      child: MaterialApp(
        title: "AdvancedBasicMoneyTracker V2",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        ),
        home: LoadingScreen(),
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
            title: const Text("ABMT V2"),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text("Extras"),
                      ),
                      body: Center(
                          child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              readCSVData(context);
                            },
                            child: Text("Reload csv"),
                          ),
                          ElevatedButton(
                            onPressed: null,
                            child: Text("Export csv"),
                          )
                        ],
                      )),
                    );
                  }))
                },
                icon: Icon(Icons.dashboard),
              ),
            ]),
        body: Column(children: [
          const SizedBox(height: 12),
          _TitleBox(),
          //
          _DisplayBox(),
          //
          InputBox(),
          //
          WeekListBox(),
        ]),
      );
    });
  }
}

class _TitleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Advanced Really Basic Money Tracker",
                style: TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text("By Me."),
          ],
        ),
      ),
    );
  }
}

class _DisplayBox extends StatelessWidget {
  Future<void> _selectDate(BuildContext context) async {
    var csvState = Provider.of<CSVState>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: csvState.pickedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setPickedDate(context, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var csvState = context.watch<CSVState>();

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total This Week: "),
              Text("\$${appState.currentSpend}"),
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                _selectDate(context),
              },
              child: Text("Week ${csvState.currentWeek}"),
            ),
          ),
        ]),
      ),
    );
  }
}
