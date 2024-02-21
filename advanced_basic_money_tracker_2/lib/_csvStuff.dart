// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';

class CSVState extends ChangeNotifier {
  String _csv = '';
  List<List<dynamic>> _csvListData = [];
  List<List<dynamic>> get csvListData => _csvListData;
  String get csv => _csv;

  void setCSV(String value) {
    _csv = value;
  }

  void setCSVListData(List<List<dynamic>> newList) {
    _csvListData = newList;
    notifyListeners();
  }

  void updateCSVListData(int index, double value) {
    _csvListData[index][1] = value;
    print(_csvListData[index].toString());
    writeCSVListData();
    notifyListeners();
  }

  void writeCSVListData() {
    _file.writeAsString(const ListToCsvConverter().convert(_csvListData));
  }
}

var _directory;
var _path;
var _file;

Future<void> startupCheck(BuildContext context) async {
  _directory = await getApplicationDocumentsDirectory();
  _path = "${_directory.path}/AdvancedBasicMoneyTracker_V2";
  _file = File('$_path/abmt.csv');
  CSVState csvState = Provider.of<CSVState>(context, listen: false);

  void createFileStuff() async {
    if (await _file.exists()) {
      //Read file
      readCSVData(context);
    } else {
      //List of List<dynamic> === List of list of any types
      // List.generate(52 elements, Week x + empty)

      List<List<dynamic>> rows = List<List<dynamic>>.generate(
          52, (index) => ['Week ${index + 1}', '']);
      csvState.setCSV(const ListToCsvConverter().convert(rows));
      _file.writeAsString(csvState.csv);
    }
  }

  if (await Directory(_path).exists()) {
    //Read file
    createFileStuff();
  } else {
    Directory(_path).create().then((Directory newPath) {
      createFileStuff();
    });
  }
}

void readCSVData(BuildContext context) async {
  //var csvState = context.watch<CSVState>();
  var csvState = Provider.of<CSVState>(context, listen: false);
  if (await _file.exists()) {
    //^ Which it should by now
    final csvFile = await _file.readAsString();
    var data =
        CsvToListConverter(eol: "\r\n", fieldDelimiter: ",").convert(csvFile);
    csvState.setCSVListData(data);
  } else {
    throw Exception("File has disappeared!");
  }
}
