import 'package:flutter_smart_timer/flutter_smart_timer.dart';

void main() {
  final timer = SmartTimer(
    customDuration: 5,
    countDownStartedTime: 120,
    countDown: true,
    intervals: [5, 10, 15],
    onTick: (int time) {
      print('tick time $time');
    },
    onComplete: (int completedTime) {
      print('completed time $completedTime');
    },
    onIntervalTick: (int intervalTime) {
      print('interval time $intervalTime');
    },
  );

  timer.start();

  Future.delayed(Duration(seconds: 7), () {
    timer.pause();
  });

  Future.delayed(Duration(seconds: 10), () {
    timer.resume();
  });
}
