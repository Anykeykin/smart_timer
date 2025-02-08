import 'dart:async';

class SmartTimer {
  Timer? _timer;
  int _currentTime = 0;
  final List<int> _intervals;
  final Function(int)? _onTick;
  final Function()? _onComplete;

  SmartTimer({
    required List<int> intervals,
    Function(int)? onTick,
    Function()? onComplete,
  })  : _intervals = intervals,
        _onTick = onTick,
        _onComplete = onComplete;

  void start() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime++;
      _onTick?.call(_currentTime);

      // Проверяем, достигли ли мы одного из интервалов
      if (_intervals.contains(_currentTime)) {
        print('$_currentTime second');
      }

      // Если время вышло
      if (_currentTime >= _intervals.last) {
        stop();
        _onComplete?.call();
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
}
