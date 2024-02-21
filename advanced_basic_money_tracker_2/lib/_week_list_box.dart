// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:advanced_basic_money_tracker_2/_csvStuff.dart';
import 'package:provider/provider.dart';

class WeekListBox extends StatelessWidget {
  const WeekListBox({super.key});
  @override
  Widget build(BuildContext context) {
    var csvState = context.watch<CSVState>();
    List<List<dynamic>> CSVData = csvState.csvListData;

    return Expanded(
      child: ListView(
        children: [
          for (dynamic item in CSVData)
            Center(
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                    child: Row(
                  children: [
                    Text("${item[0]}: "),
                    SizedBox(
                      width: 10,
                    ),
                    Text(item[1].toString()),
                  ],
                )),
              ),
            )

          //Text(item.toString()),
        ],
      ),
    );
  }
}

// class WeekListBox extends StatelessWidget {
//   const WeekListBox({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final Future<List<List<dynamic>>> CSVData = readCSVData(context);
//     return FutureBuilder(
//       future: CSVData,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<List<dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return (Text("Error! ${snapshot.toString()}"));
//         } else {
//           List<List<dynamic>>? data = snapshot.data;
//           return Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               child: ListView(
//                 padding: const EdgeInsets.all(8),
//                 children: [
//                   for (dynamic item in data!)
//                     Container(
//                         height: 50,
//                         child: Row(
//                           children: [
//                             Text("${item[0]}: "),
//                             Text(item[1].toString()),
//                           ],
//                         ))
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }