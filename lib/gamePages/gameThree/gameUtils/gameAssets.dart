import 'package:flutter/material.dart';

// ignore: camel_case_types
class IMGS {
  Visibility gameImg(bool visibility, String path) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset(path),
      ),
    );
  }
}
