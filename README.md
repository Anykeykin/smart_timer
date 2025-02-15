
# SmartTimer 🕒

SmartTimer is a powerful and flexible library on Dart for working with timers. It supports countdown, intervals, custom durations, and event notifications via streams. It is ideal for creating timers in Dart and Flutter applications.



## The possibilities 🌟

🕒 Timer with intervals: Specify the intervals at which events will be triggered.

⏳ Countdown: Support for countdown timers.

⏱️ Custom duration: Set your own duration for each tick.

🔄 Streams: Receive notifications about ticks, intervals, and completion via Stream.

⏯️ Pause and Resume: Control the timer with pause and resume.

🚀 Easy to use: A simple and intuitive API.


## Installation 📦
Add the dependency to your pubspec.yaml:

```yaml
  dependencies:
  smart_timer: ^1.1.6
```
Then run:
```bash
  dart pub get
```

## Use 🚀
A simple timer:

```dart
import 'package:smart_timer/smart_timer.dart';

void main() {
  final timer = SmartTimer(
    endTime: 10,
    countDown: false,
    intervals: [5, 10],
    onTick: (time) => print('Tick: $time'),
    onIntervalTick: (time) => print('Interval: $time'),
    onComplete: (time) => print('Completed!'),
  );

  timer.start();
}
```

The countdown
```dart
final timer = SmartTimer(
  endTime: 0,
  countDown: true,
  countDownStartedTime: Duration(seconds: 60),
  intervals: [30, 0],
  onTick: (time) => print('Tick: $time'),
  onComplete: (time) => print('Time\'s up!'),
);

timer.start();
```

Streams
```dart
timer.onTick.listen((duration) {
  print('Current time: ${duration.inSeconds}');
});

timer.onComplete.listen((duration) {
  print('Timer completed at ${duration.inSeconds} seconds');
});
```

## API 📚
### Basic methods
start(): Starts the timer.

pause(): Pauses the timer.

resume(): Resumes the timer.

stop(): Stops the timer and resets the time.

dispose(): Closes all threads and releases resources.

### Properties
currentTime : The current timer time.

isActive: Returns true if the timer is active.

onTick: A thread for tick events.

onInterval: A stream for interval events.

onComplete: The thread for the completion event.

## Support 🤝

If you have any suggestions or have found a bug, please create an issue. We also welcome your Pull Request!


## License 📄

This project is distributed under the MIT license. For more information, see the LICENSE file.

## Author 👨💻

Designed with https://github.com/Anykeykin
