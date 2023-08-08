import 'package:flutter/material.dart';

class ComputerDict extends StatelessWidget {
  ComputerDict({Key? key}) : super(key: key);

  // computer words and meaning
  Map<String, String> computerWords = {
    'CPU': 'Central Processing Unit',
    'ALU': 'Arithmetic Logic Unit',
    'CU': 'Control Unit',
    'HDD': 'Hard Disk Drive',
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: computerWords.length,
        itemBuilder: (context, index) {
          String key = computerWords.keys.elementAt(index);
          String value = computerWords.values.elementAt(index);
          return ListTile(
            title: Text(
              '$key',
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '$value',
              style: TextStyle(fontFamily: 'Rubik', fontSize: 15.0),
            ),
          );
        });
  }
}
