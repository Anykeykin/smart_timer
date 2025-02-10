import 'package:flutter_smart_timer/flutter_smart_timer.dart';

void main() {
  final timer = SmartTimer(
    customDuration: 5,
    intervals: [5, 10, 15],
    onTick: (int time) {
      print('tick time $time');
    },
    onComplete: (int completedTime) {
      print('completed time $completedTime');
    },
  );

  timer.start();

  Future.delayed(Duration(seconds: 7), () {
    timer.pause();
  });

  Future.delayed(Duration(seconds: 10), () {
    timer.resume();
  });

  Future.delayed(Duration(seconds: 20), () {
    timer.stop();
  });
}
