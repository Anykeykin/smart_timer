import 'package:smart_timer/smart_timer.dart';

void main() {
  final timer = SmartTimer(
    intervals: [5, 10, 15],
    onTick: (time) {
      print('Тик: $time секунд');
    },
    onComplete: () {
      print('Таймер завершён!');
    },
  );

  timer.start();

  Future.delayed(Duration(seconds: 7), () {
    timer.pause();
    print('Таймер на паузе');
  });

  Future.delayed(Duration(seconds: 10), () {
    timer.resume();
    print('Таймер возобновлён');
  });

  Future.delayed(Duration(seconds: 20), () {
    timer.stop(); 
    print('Таймер остановлен');
  });
}
