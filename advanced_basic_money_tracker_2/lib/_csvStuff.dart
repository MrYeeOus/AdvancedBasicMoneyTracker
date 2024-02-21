// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';

class CSVState extends ChangeNotifier {
  String _csv = '';
  String get csv => _csv;

  void setCSV(String value) {
    _csv = value;
    notifyListeners();
  }
}

Future<void> startupCheck(BuildContext context) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = "${directory.path}/AdvancedBasicMoneyTracker_V2";
  final file = File('$path/abmt.csv');
  // print("File is at: ");
  // print(file.toString);
  // print(path.toString());
  // print(directory.toString());
  CSVState csvState = Provider.of<CSVState>(context, listen: false);

  void fileStuff() async {
    if (await file.exists()) {
      //Read file
    } else {
      //List of List<dynamic> === List of list of any types
      // List.generate(52 elements, Week x + empty)

      List<List<dynamic>> rows = List<List<dynamic>>.generate(
          52, (index) => ['Week ${index + 1}', '']);
      csvState.setCSV(const ListToCsvConverter().convert(rows));
      file.writeAsString(csvState.csv);
    }
  }

  if (await Directory(path).exists()) {
    //Read file
    fileStuff();
  } else {
    Directory(path).create().then((Directory newPath) {
      fileStuff();
    });
  }
}
