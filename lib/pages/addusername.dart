import 'package:capstoneapp1/pages/addusernameUtils.dart';
import 'package:capstoneapp1/pages/menuPage.dart';
import 'package:flutter/material.dart';

class AddUsername extends StatelessWidget {
  AddUsername({Key? key});
  Note _note = Note();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Wrap the Column with Expanded
            const SizedBox(
              height: 200,
            ),
            Text(
              "Create Nickname",
              style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 20.0,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 80,
                width: 330,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 260,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                              focusColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MenuPage()));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
            Note(),
          ],
        ),
      ),
    );
  }
}
