import 'dart:async';

import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameOptions.dart';
import 'package:get/get.dart';

class TimerController {
  Timer? timer;
  int remainingSeconds = 0;
  final time = '03.00'.obs;

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == -1) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }
}
