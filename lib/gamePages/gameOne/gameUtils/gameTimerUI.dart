import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerUI extends GetView<TimerController> {
  const TimerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TimerController());
    return Scaffold(
        body: Center(
      child: Container(
        height: 40,
        width: 70,
        decoration: ShapeDecoration(
            color: Theme.of(context).primaryColor,
            shape:
                StadiumBorder(side: BorderSide(width: 2, color: Colors.white))),
        child: Obx(() => Center(
              child: Row(
                children: [
                  Icon(Icons.timer_sharp),
                  Text(
                    '${controller.time.value}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
