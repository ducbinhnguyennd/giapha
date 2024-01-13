String getNameDayOfWeek(DateTime date) {
  if (date.weekday == DateTime.monday) {
    return "THỨ HAI";
  }
  if (date.weekday == DateTime.tuesday) {
    return "THỨ BA";
  }
  if (date.weekday == DateTime.wednesday) {
    return "THỨ TƯ";
  }
  if (date.weekday == DateTime.thursday) {
    return "THỨ NĂM";
  }
  if (date.weekday == DateTime.friday) {
    return "THỨ SÁU";
  }
  if (date.weekday == DateTime.saturday) {
    return "THỨ BẢY";
  }
  return "CHỦ NHẬT";
}

DateTime increaseDay(DateTime date) {
  var day = date.day + 1;
  var month = date.month;
  var year = date.year;
  var maxDayThisMonth = lastDayOfMonth(date);
  if (maxDayThisMonth.day == day) {
    day = 1;
    month++;
    if (date.month == 12) {
      month = 1;
      year++;
    }
  }

  return DateTime(year, month, day, date.hour, date.minute, date.second);
}

DateTime decreaseDay(DateTime date) {
  var day = date.day - 1;
  var month = date.month;
  var year = date.year;
  if (date.day == 1) {
    var maxDayPreviousMonth = lastDayOfPreviousMonth(date);
    day = maxDayPreviousMonth.day;
    month = maxDayPreviousMonth.month;
    year = maxDayPreviousMonth.year;
  }

  return DateTime(year, month, day, date.hour, date.minute, date.second);
}

DateTime lastDayOfMonth(DateTime date) {
  if (date.month < 12) {
    return DateTime(date.year, date.month + 1, 0);
  }
  return DateTime(date.year + 1, 1, 0);
}

DateTime lastDayOfPreviousMonth(DateTime date) {
  return DateTime(date.year, date.month, 0);
}
