// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:advanced_basic_money_tracker_2/_csvStuff.dart';

class WeekListBox extends StatelessWidget {
  final Future<List<List<dynamic>>> CSVData = readCSVData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CSVData,
      builder:
          (BuildContext context, AsyncSnapshot<List<List<dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return (Text("Error! ${snapshot.toString()}"));
        } else {
          List<List<dynamic>>? data = snapshot.data;

          // return ListView.builder(
          //   itemCount: data!.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text("Week ${index + 1}"),
          //       subtitle: Text("${data[index]}"),
          //     );
          //   },
          // );
          // return Text("$data");
          print("dtaa");
          print(data);
          return Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  for (dynamic item in data!)
                    Container(
                        height: 50,
                        child: Row(
                          children: [
                            Text("${item[0]}: "),
                            Text(item[1].toString()),
                          ],
                        ))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

// class _WeekListBoxState extends State<WeekListBox> {
//   Future<List<List<dynamic>>> getCSVList = readCSVData();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Expanded>(
//       future: getCSVList,
//       builder: (BuildContext context, AsyncSnapshot<List<List<dynamic>>> snapshot)  {

//       }

//       child: ListView(padding: const EdgeInsets.all(8), children: [
//         // for (var i = 0; i < 52; i++)
//         //   Container(
//         //     height: 50,
//         //     child: Row(
//         //       children: [
//         //         Text("Week ${i + 1}:"),
//         //       ],
//         //     ),
//         //   ),

//         for (List<dynamic> outerList in getCSVList)
//           for (dynamic item in outerList)
//             Container(
//               height: 50,
//               child: Row(
//                 children: [
//                   Text("$outerList $item"),
//                 ],
//               ),
//             ),
//       ]),
//     );
//   }
// }