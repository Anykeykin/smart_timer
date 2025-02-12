import 'dart:async';

class SmartTimer {
  /// stream controllers for indicate changes with listen
  final StreamController<Duration> _tickController =
      StreamController.broadcast();
  final StreamController<Duration> _intervalController =
      StreamController.broadcast();
  final StreamController<Duration> _completeController =
      StreamController.broadcast();

  Timer? _timer;

  /// custom duration for change timer tick periodic
  Duration? customDuration;
  Duration? countDownStartedTime;
  Duration _currentTime = Duration.zero;
  final int endTime;
  final bool countDown;
  final List<int> _intervals;
  final Function(int)? _onTick;
  final Function(int)? _onIntervalTick;

  /// callback for call on timer complete
  final Function(int)? _onComplete;

  SmartTimer({
    this.customDuration,
    this.countDownStartedTime,
    required this.endTime,
    required this.countDown,
    required List<int> intervals,
    Function(int)? onTick,
    Function(int)? onIntervalTick,
    Function(int)? onComplete,
  })  : _intervals = intervals,
        _onTick = onTick,
        _onComplete = onComplete,
        _onIntervalTick = onIntervalTick;

  void start() {
    if (isActive) return;
    if (countDown) {
      _currentTime = countDownStartedTime ?? Duration(seconds: 60);
    } else {
      _currentTime = Duration.zero;
    }

    resume();
  }

  void pause() {
    _timer?.cancel();
  }

  /// Resumed timer
  void resume() {
    _timer = Timer.periodic(customDuration ?? Duration(seconds: 1), (timer) {
      if (countDown) {
        _currentTime -= Duration(seconds: 1);
      } else {
        _currentTime += Duration(seconds: 1);
      }

      _tickController.add(_currentTime);
      _onTick?.call(_currentTime.inSeconds);

      if (_intervals.contains(_currentTime.inSeconds)) {
        _intervalController.add(_currentTime);
        _onIntervalTick?.call(_currentTime.inSeconds);
      }

      if (endTime == _currentTime.inSeconds) {
        _completeController.add(_currentTime);
        _onComplete?.call(_currentTime.inSeconds);
        stop();
      }
    });
  }

  /// Stoped timer
  void stop() {
    _timer?.cancel();
    _currentTime = Duration.zero;
  }

  /// dispose streamControllers
  void dispose() {
    _tickController.close();
    _intervalController.close();
    _completeController.close();
  }

  Duration get currentTime => _currentTime;

  bool get isActive => _timer?.isActive ?? false;

  Stream<Duration> get onTick => _tickController.stream;

  Stream<Duration> get onInterval => _intervalController.stream;

  Stream<Duration> get onComplete => _completeController.stream;
}
