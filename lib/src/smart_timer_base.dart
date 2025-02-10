import 'dart:async';

class SmartTimer {
  Timer? _timer;
  /// custom duration for change timer tick periodic
  int? customDuration;
  int _currentTime = 0;
  final List<int> _intervals;
  final Function(int)? _onTick;
  final Function(int)? _onIntervalTick;
  /// callback for call on timer complete
  final Function(int)? _onComplete;

  SmartTimer({
    this.customDuration,
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
    _timer = Timer.periodic(Duration(seconds: customDuration ?? 1), (timer) {
      _currentTime++;
      _onTick?.call(_currentTime);

      if (_intervals.contains(_currentTime)) {
        _onIntervalTick?.call(currentTime);
      }

      if (_currentTime >= _intervals.last) {
        _onComplete?.call(_currentTime);
        stop();
      }
    });
  }

  void pause() {
    _timer?.cancel();
  }

  /// Resumed timer
  void resume() {
    start();
  }

  /// Stoped timer
  void stop() {
    _timer?.cancel();
    _currentTime = 0;
  }

  int get currentTime => _currentTime;

  bool get isActive => _timer?.isActive ?? false;
}
