import 'dart:async';

class StoppableTimer {
  final int duration;
  Timer? _timer;

  StoppableTimer(this.duration);

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => print('Tick!'));
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}

void main() {
  final timer = StoppableTimer(5); // 5 second timer

  timer.start(); // Start timer

  // Some time later

  timer.stop(); // Stop timer
}
