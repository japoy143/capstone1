import 'package:capstoneapp1/components/allComputerWords.dart';
import 'package:flutter/material.dart';

import 'Dictionaries/ComputerWordsList.dart';

class ComputerDict extends StatelessWidget {
  ComputerDict({Key? key}) : super(key: key);

  //Computer Words list Directory Class
  CompWords computerWords = CompWords();

  // computer words and meaning

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: computerWords.ComputerWordsList.length,
        itemBuilder: (context, index) {
          String key = computerWords.ComputerWordsList.keys.elementAt(index);
          String value =
              computerWords.ComputerWordsList.values.elementAt(index);
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllComputerWords()));
            },
            title: Text(
              key,
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              value,
              style: const TextStyle(fontFamily: 'Rubik', fontSize: 15.0),
            ),
          );
        });
  }
}
