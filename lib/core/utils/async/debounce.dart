import 'dart:async';

class Debounce {
  Debounce({this.ms = 100});

  final int ms;
  Timer? _time;

  void run(void Function() action) {
    if (_time?.isActive ?? false) _time?.cancel();
    _time = Timer(Duration(milliseconds: ms), action);
  }

  void dispose() => _time?.cancel();
}
