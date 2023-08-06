import 'package:flutter/material.dart';

class AddUsername extends StatelessWidget {
  const AddUsername({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // Wrap the Column with Expanded
            child: TextField(
              decoration: InputDecoration(
                labelText:
                    'Create Nickname', // Use `labelText` instead of `label`
              ),
            ),
          ),
        ],
      ),
    );
  }
}
