import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/models/wordcollection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DefinitionSummary extends StatefulWidget {
  const DefinitionSummary({super.key});

  @override
  State<DefinitionSummary> createState() => _DefinitionSummaryState();
}

class _DefinitionSummaryState extends State<DefinitionSummary> {
  late Box<WordCollection> wordCollectionBox;

  CompWords compWords = CompWords();

  @override
  void initState() {
    wordCollectionBox = Hive.box<WordCollection>('wordcollection');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: wordCollectionBox.length,
          itemBuilder: (context, index) {
            final user = wordCollectionBox.getAt(index);
            final collection = user!.wordcollected;
            final date = user.date;
            List WordCollection = [];
            var comp = compWords.ComputerWordsList;
            comp = comp.map((key, value) => MapEntry(key.toUpperCase(), value));
            String formatted_Date = DateFormat('MM-dd-yyyy').format(date);
            collection.forEach((element) {
              if (comp.containsKey(element)) {
                String? value = '$element - ${comp[element]}';
                WordCollection.add(value);
              }
              ;
            });

            return Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            user!.username.toString(),
                            style: TextStyle(
                                fontFamily: 'rubik',
                                fontSize: 25,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: WordCollection.map((e) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )).toList(),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 5),
                          child: Text(
                            formatted_Date,
                            style: TextStyle(
                                fontFamily: 'rubik',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
