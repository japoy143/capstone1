import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/components/Dictionaries/GeneralwordsList.dart';
import 'package:capstoneapp1/components/SelectedGenWord.dart';
import 'package:flutter/material.dart';

class AllGeneralWords extends StatelessWidget {
  AllGeneralWords({super.key});

  //genwords
  GenWords gen = GenWords();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: gen.gWords.length,
                  itemBuilder: (context, index) {
                    String key = gen.gWords.keys.elementAt(index);
                    String value = gen.gWords.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 150.0, minHeight: 50.0),
                        child: ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowSelectedGenWord(
                                        indexPass: index,
                                      ))),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          tileColor: Colors.green[400],
                          selectedColor: Colors.amber,
                          leading: Text(
                            key,
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
