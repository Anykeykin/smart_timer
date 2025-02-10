import 'dart:async';

class SmartTimer {
  Timer? _timer;
  int _currentTime = 0;
  final List<int> _intervals;
  final Function(int)? _onTick;
  final Function(int)? _onComplete;

  SmartTimer({
    required List<int> intervals,
    Function(int)? onTick,
    Function(int)? onComplete,
  })  : _intervals = intervals,
        _onTick = onTick,
        _onComplete = onComplete {
    if (_intervals.isEmpty) {
      throw ArgumentError('Intervals list cannot be empty');
    }
  }

  void start() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime++;
      _onTick?.call(_currentTime);

      if (_intervals.contains(_currentTime)) {
        print('$_currentTime second');
      }

      if (_currentTime >= _intervals.last) {
        stop();
        _onComplete?.call(_currentTime);
      }
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void resume() {
    start();
  }

  void stop() {
    _timer?.cancel();
    _currentTime = 0;
  }

  int get currentTime => _currentTime;

  bool get isActive => _timer?.isActive ?? false;
}