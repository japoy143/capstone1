import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/components/SearchComponents/CompWordSearch.dart';
import 'package:capstoneapp1/components/SelectedCompWord.dart';
import 'package:flutter/material.dart';

class AllComputerWords extends StatelessWidget {
  AllComputerWords({super.key});

  CompWords computerWords = CompWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Computer Words',
          style: TextStyle(fontFamily: 'Rubik', fontSize: 20.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustiomSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: computerWords.ComputerWordsList.length,
                  itemBuilder: (context, index) {
                    String key =
                        computerWords.ComputerWordsList.keys.elementAt(index);
                    String value =
                        computerWords.ComputerWordsList.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 150.0, minHeight: 50.0),
                        child: ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowSelectedComWords(
                                        IndexPass: index,
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

class CustiomSearchDelegate extends SearchDelegate {
  CompWords _compWords = CompWords();

  //clear the search bar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //close the search bar
  @override
  Widget buildLeading(BuildContext context) {
    return (IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    ));
  }

  //the search funct
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    for (var key in _compWords.ComputerWordsList.keys) {
      if (key.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(key);
      }
    }
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: (context, index) {
          var result = matchquery[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CompWordSearch(value: result)));
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    for (var key in _compWords.ComputerWordsList.keys) {
      if (key.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(key);
      }
    }
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: (context, index) {
          var result = matchquery[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CompWordSearch(value: result)));
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        });
  }
}
