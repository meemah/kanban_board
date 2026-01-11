extension IntExtension on int {
  String get formatDuration {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    final seconds = this % 60;

    // Pad with zeros if needed
    final hoursStr = hours.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
