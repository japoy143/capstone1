import 'package:capstoneapp1/pages/addusernameUtils.dart';
import 'package:capstoneapp1/pages/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class AddUsername extends StatefulWidget {
  AddUsername({Key? key});

  @override
  State<AddUsername> createState() => _AddUsernameState();
}

class _AddUsernameState extends State<AddUsername> {
  Note _note = Note();

  TextEditingController usernameController = TextEditingController();

  late Box userBox;
  bool isTextFieldEmpty = true;

  void Onsave() async {
    try {
      await userBox.add(usernameController.text);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuPage(nameUser: usernameController.text)));
      print('Data Save Successfully');
    } catch (e) {
      print(e);
    }
  }

  void onDelete(int index) {
    userBox.deleteAt(index);
    print('deleted');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('newUsers');
  }

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
              "Create Username",
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
                          onChanged: (value) {
                            setState(() {
                              isTextFieldEmpty = value.isEmpty;
                            });
                          },
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
                          controller: usernameController,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: isTextFieldEmpty ? null : Onsave,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Select Users',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Rubik',
                  color: Colors.green[400],
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: 150,
              child: ListView.builder(
                  itemCount: userBox.length,
                  itemBuilder: (context, index) {
                    final newusers = userBox.getAt(index);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MenuPage(nameUser: newusers)));
                        },
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (index) {
                                userBox.deleteAt(newusers[index]);
                              },
                              foregroundColor: Colors.green[400],
                              icon: Icons.delete,
                            )
                          ]),
                          child: Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(9.0)),
                            child: Center(
                              child: Text(
                                newusers,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Note(),
            ),
          ],
        ),
      ),
    );
  }
}
