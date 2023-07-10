String formatTime(int seconds) {
  return (seconds > 59)
      ? "${(seconds / 60).floor()}:${(seconds % 60).toString().padLeft(2, "0")}"
      : "00:${(seconds % 60).toString().padLeft(2, "0")}";
}
