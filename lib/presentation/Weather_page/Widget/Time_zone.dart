String formatTimeZone(int? timeZoneOffsetSeconds) {
  if (timeZoneOffsetSeconds == null) {
    return ''; // or any default value you prefer for null timezones
  }
  // Calculate hours and minutes
  int hours = timeZoneOffsetSeconds ~/ 3600;
  int minutes = (timeZoneOffsetSeconds.abs() % 3600) ~/ 60;

  // Construct the formatted string
  String sign = timeZoneOffsetSeconds >= 0 ? '+' : '-';
  String hoursStr = hours.abs().toString().padLeft(2, '0');
  String minutesStr = minutes.abs().toString().padLeft(2, '0');

  return 'UTC$sign$hoursStr:$minutesStr';
}
