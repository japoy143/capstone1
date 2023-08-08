import 'package:flutter/material.dart';

class GeneralDict extends StatelessWidget {
  GeneralDict({Key? key}) : super(key: key);

  //general words list
  Map<String, String> genWords = {
    'Accept': 'consent to receive ',
    'Compare':
        'estimate, measure, or note the similarity or dissimilarity between.',
    'Development': 'the process of developing or being developed.',
    'Federal': 'relating to or denoting the central government',
    'House':
        'a building that serves as living quarters for one or a few families ',
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: genWords.length,
        itemBuilder: (context, index) {
          String key = genWords.keys.elementAt(index);
          String value = genWords.values.elementAt(index);
          return ListTile(
            title: Text(
              key,
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(value,
                style: TextStyle(fontFamily: 'Rubik', fontSize: 15.0)),
          );
        });
  }
}
