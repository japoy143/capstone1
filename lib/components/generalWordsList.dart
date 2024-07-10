import 'package:capstoneapp1/components/Dictionaries/GeneralwordsList.dart';
import 'package:capstoneapp1/components/allGeneralWords.dart';
import 'package:flutter/material.dart';

class GeneralDict extends StatelessWidget {
  GeneralDict({Key? key}) : super(key: key);

  //class where the general words list located
  GenWords genWords = GenWords();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: genWords.gWords.length,
        itemBuilder: (context, index) {
          String key = genWords.gWords.keys.elementAt(index);
          String value = genWords.gWords.values.elementAt(index);
          return ListTile(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllGeneralWords())),
            title: Text(
              key,
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(value,
                style: const TextStyle(fontFamily: 'Rubik', fontSize: 15.0)),
          );
        });
  }
}
