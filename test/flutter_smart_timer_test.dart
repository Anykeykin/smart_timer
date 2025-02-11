import 'package:flutter_smart_timer/flutter_smart_timer.dart';
import 'package:test/test.dart';
import 'dart:async';

void main() {
  group('SmartTimer', () {
    late SmartTimer timer;

    setUp(() {
      timer = SmartTimer(
        endTime: 10,
        countDown: false,
        intervals: [5, 10],
        onTick: (time) => print('Tick: $time'),
        onIntervalTick: (time) => print('Interval: $time'),
        onComplete: (time) => print('Complete: $time'),
      );
    });

    tearDown(() {
      timer.stop();
    });

    test('starts and stops correctly', () {
      expect(timer.isActive, false);
      timer.start();
      expect(timer.isActive, true);
      timer.stop();
      expect(timer.isActive, false);
    });

    test('pauses and resumes correctly', () {
      timer.start();
      expect(timer.isActive, true);
      timer.pause();
      expect(timer.isActive, false);
      timer.resume();
      expect(timer.isActive, true);
    });

    test('emits tick events correctly', () async {
      timer.start();
      final tickEvents = <Duration>[];
      final subscription = timer.onTick.listen(tickEvents.add);

      await Future.delayed(Duration(seconds: 3));
      expect(tickEvents.length, greaterThanOrEqualTo(2));
      subscription.cancel();
    });

    test('emits interval events correctly', () async {
      timer.start();
      final intervalEvents = <Duration>[];
      final subscription = timer.onInterval.listen(intervalEvents.add);

      await Future.delayed(Duration(seconds: 6));
      expect(intervalEvents.length, 1);
      expect(intervalEvents.first.inSeconds, 5);
      subscription.cancel();
    });

    test('emits complete event correctly', () async {
      timer.start();
      final completeEvents = <Duration>[];
      final subscription = timer.onComplete.listen(completeEvents.add);

      await Future.delayed(Duration(seconds: 11));
      expect(completeEvents.length, 1);
      expect(completeEvents.first.inSeconds, 10);
      subscription.cancel();
    });

    test('countdown mode works correctly', () async {
      final countdownTimer = SmartTimer(
        endTime: 0,
        countDown: true,
        countDownStartedTime: Duration(seconds: 5),
        intervals: [2, 0],
        onTick: (time) => print('Tick: $time'),
        onIntervalTick: (time) => print('Interval: $time'),
        onComplete: (time) => print('Complete: $time'),
      );

      countdownTimer.start();
      final tickEvents = <Duration>[];
      final subscription = countdownTimer.onTick.listen(tickEvents.add);

      await Future.delayed(Duration(seconds: 6));
      expect(tickEvents.length, greaterThanOrEqualTo(5));
      subscription.cancel();
      countdownTimer.stop();
    });
  });
}
