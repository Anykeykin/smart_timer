import 'dart:async';

class SmartTimer {
  Timer? _timer;

  /// custom duration for change timer tick periodic
  int? customDuration;
  int? countDownStartedTime;
  int _currentTime = 0;
  final bool countDown;
  final List<int> _intervals;
  final Function(int)? _onTick;
  final Function(int)? _onIntervalTick;

  /// callback for call on timer complete
  final Function(int)? _onComplete;

  SmartTimer({
    this.customDuration,
    this.countDownStartedTime,
    required this.countDown,
    required List<int> intervals,
    Function(int)? onTick,
    Function(int)? onIntervalTick,
    Function(int)? onComplete,
  })  : _intervals = intervals,
        _onTick = onTick,
        _onComplete = onComplete,
        _onIntervalTick = onIntervalTick {
    if (_intervals.isEmpty) {
      throw ArgumentError('Intervals list cannot be empty');
    }
  }

  void start() {
    if (isActive) return;
    if (countDown) {
      _currentTime = countDownStartedTime ?? 60;
    } else {
      _currentTime = 0;
    }

    resume();
  }

  void pause() {
    _timer?.cancel();
  }

  /// Resumed timer
  void resume() {
    _timer = Timer.periodic(Duration(seconds: customDuration ?? 1), (timer) {
      if (countDown) {
        _currentTime--;
      } else {
        _currentTime++;
      }

      _onTick?.call(_currentTime);

      if (_intervals.contains(_currentTime)) {
        _onIntervalTick?.call(currentTime);
      }

      if ((countDown && _currentTime <= 0) ||
          (!countDown && _currentTime >= _intervals.last)) {
        _onComplete?.call(_currentTime);
        stop();
      }
    });
  }

  /// Stoped timer
  void stop() {
    _timer?.cancel();
    _currentTime = 0;
  }

  int get currentTime => _currentTime;

  bool get isActive => _timer?.isActive ?? false;
}
