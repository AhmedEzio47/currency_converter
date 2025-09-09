extension DateFormatting on DateTime {
  String get formattedYMD {
    return "${year.toString().padLeft(4, '0')}-"
        "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }

  String get formattedMD {
    return "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }

  String get formattedDayMonthAbbr {
    const monthAbbr = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${day.toString().padLeft(2, '0')}-${monthAbbr[month - 1]}";
  }
}
