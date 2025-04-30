// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:advanced_basic_money_tracker_2/main.dart';

class CSVState extends ChangeNotifier {
  String _csv = '';
  List<List<dynamic>> _csvListData = [];
  List<List<dynamic>> get csvListData => _csvListData;
  int _currentWeek = 0;
  int get currentWeek => _currentWeek;
  DateTime _pickedDate = DateTime.now();
  DateTime get pickedDate => _pickedDate;
  String get csv => _csv;

  void setCSV(String value) {
    _csv = value;
  }

  void setCSVListData(List<List<dynamic>> newList) {
    _csvListData = newList;
    notifyListeners();
  }

  void updateCSVListData(int index, double value) {
    _csvListData[index][1] += value;
    switch(_selectedCategory) {
      case 'Necessary':
        _csvListData[index][2] += value;
        break;
      case 'Frivolous':
        _csvListData[index][3] += value;
        break;
      case 'Repayment':
        _csvListData[index][4] += value;
        break;
    }
    //print(_csvListData[index].toString());
    writeCSVListData();
    notifyListeners();
  }

  void writeCSVListData() {
    _file.writeAsString(const ListToCsvConverter().convert(_csvListData));
  }

  int getPickedWeekNo() {
    final date = _pickedDate;
    final fir = DateTime(date.year, 1, 1).weekday;
    int wn =
        ((int.parse(DateFormat('D').format(date)) + (8 - fir)) / 7).floor();

    return wn;
  }

  void doNotifyListeners() {
    notifyListeners();
  }


  //30Apr25
  List<String> _defaultColumnNames = [
    'Week',
    'Total',
    'Necessary',
    'Frivolous',
    'Repayment'
  ];
  List<String> get defaultColumnNames => _defaultColumnNames;

  void addColumn(String columnName) {
    if (!_defaultColumnNames.contains(columnName))  {
      _defaultColumnNames.add(columnName);
      notifyListeners();
    }
  }
  void removeColumn(String columnName)  {
    if (!_defaultColumnNames.contains(columnName))  {
      _defaultColumnNames.remove(columnName);
      notifyListeners();
    }
  }

  String _selectedCategory = 'Frivolous';

  get selectedCategory => _selectedCategory;
  void chooseCategory(String category)  {
    _selectedCategory = category;
    notifyListeners();
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

      // 30Apr25 - Add extra columns for default: now == {Week, total, necessary, frivolous, repayment}
      List<List<dynamic>> rows = List<List<dynamic>>.generate(
          53, (index) => ['Week ${index + 1}', '0.0', '0.0', '0.0', '0.0']);
      csvState.setCSV(const ListToCsvConverter().convert(rows));
      _file.writeAsString(csvState.csv);
    }
  }

  if (await Directory(_path).exists() && !(await _file.exists())) {
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
  //Set week number for display and workings
  setPickedDate(context, DateTime.now());
}

void setPickedDate(BuildContext context, DateTime picked) {
  var appState = Provider.of<MyAppState>(context, listen: false);
  var csvState = Provider.of<CSVState>(context, listen: false);

  //From calendar widget
  csvState._pickedDate = picked;
  var n = csvState.getPickedWeekNo();
  csvState._currentWeek = n;
  csvState.doNotifyListeners();

  var currSpend = csvState._csvListData[n - 1][1];
  currSpend ??= 0.0;
  print(currSpend);
  appState.setCurrentSpend(currSpend);
}
