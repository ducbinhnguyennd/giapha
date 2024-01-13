import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import "dart:math";

import 'package:intl/intl.dart';

enum Timezone {
  Chinese,
  Japanese,
  Korean,
  Vietnamese,
}

enum ModeScroll {
  Up,
  Down,
}

class DateTimeCommon {
  static String formatDateDefault = "dd/MM/yyyy";
  static String formatTime(BuildContext context, DateTime date) {
    try {
      DateFormat dateFormat;
      if (MediaQuery.of(context).alwaysUse24HourFormat) {
        dateFormat =
            DateFormat.Hm(Localizations.localeOf(context).languageCode);
      } else {
        dateFormat =
            DateFormat.jm(Localizations.localeOf(context).languageCode);
      }
      return dateFormat.format(date);
    } catch (error) {
      // Logger.e("Error with time format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static String formatDateNoContext(DateTime date) {
    try {
      const datePattern = "d-M-yyyy";
      final dateFormat = DateFormat(datePattern);
      String day = dateFormat.format(date);

      return day;
    } catch (error) {
      // Logger.e("Error with date format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static Map fomularDateLoadData(DateTime dateTime) {
    Map param = HashMap();
    if (dateTime.month == 1) {
      param.putIfAbsent(0, () => DateTime(dateTime.year - 1, 11, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 3, 0));
    } else if (dateTime.month == 2) {
      param.putIfAbsent(0, () => DateTime(dateTime.year - 1, 12, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 4, 0));
    } else if (dateTime.month == 3) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 1, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 5, 0));
    } else if (dateTime.month == 4) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 2, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 6, 0));
    } else if (dateTime.month == 5) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 3, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 7, 0));
    } else if (dateTime.month == 6) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 4, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 8, 0));
    } else if (dateTime.month == 7) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 5, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 9, 0));
    } else if (dateTime.month == 8) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 6, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 10, 0));
    } else if (dateTime.month == 9) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 7, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 11, 0));
    } else if (dateTime.month == 10) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 8, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 12, 0));
    } else if (dateTime.month == 11) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 9, 25));
      param.putIfAbsent(1, () => DateTime(dateTime.year, 12, 31));
    } else if (dateTime.month == 12) {
      param.putIfAbsent(0, () => DateTime(dateTime.year, 10, 25));
      // if (DateTime.now().year == dateTime.year) {
      //   param.putIfAbsent(
      //       1,
      //       () => DateTime(dateTime.year + 1, 1, 1)
      //           .subtract(const Duration(days: 1)));
      // } else {
      param.putIfAbsent(1, () => DateTime(dateTime.year + 1, 1, 31));
      // }
    }

    return param;
  }

  static Map fomularDateLoadDataEvent(
      DateTime dateTime, ModeScroll modeScroll) {
    Map param = HashMap();
    int monthAdd = 0;
    int yearAdd = dateTime.year;
    param.putIfAbsent(0, () => DateTime(dateTime.year, dateTime.month, 1));
    if (modeScroll == ModeScroll.Down) {
      monthAdd = dateTime.month + 4;

      if (monthAdd > 12) {
        monthAdd = monthAdd - 12;
        yearAdd = yearAdd + 1;
      }
      param.putIfAbsent(
          1,
          () =>
              DateTime(yearAdd, monthAdd, 1).subtract(const Duration(days: 1)));
    } else {
      monthAdd = dateTime.month - 4;
      if (monthAdd < 1) {
        monthAdd = 12 + monthAdd;
        yearAdd = yearAdd - 1;
      }

      param.putIfAbsent(
          1,
          () => DateTime(dateTime.year, dateTime.month - 4, 1)
              .subtract(const Duration(days: 1)));
    }

    return param;
  }

  static String dateTimeToStringLength8(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String dateTimeToStringDefault(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String dateTimeToStringLength9(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
  }

  static DateTime formatStringToDate5(String date) {
    return DateFormat('d-M-yyyy').parse(date);
  }

  static DateTime formatStringToDate9(String date) {
    return DateFormat('dd-MM-yyyy').parse(date);
  }

  static DateTime formatStringToDateZ(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  }

  static DateTime formatStringToDateZeroHour(String date) {
    DateTime dateConver = formatStringToDateZ(date);
    DateTime dateFormatZeroHour =
        DateTime(dateConver.year, dateConver.month, dateConver.day);
    return dateFormatZeroHour;
  }

  static DateTime formatDateTimeToString(String dateTime) {
    return DateFormat('yyyy-MM-dd').parse(dateTime);
  }

  //Get timezone by locate
  static int getTimeZoneValue(Timezone timezone) {
    switch (timezone) {
      case Timezone.Chinese:
        return 8; //UTC +08
      case Timezone.Japanese:
        return 9; //UTC +09
      case Timezone.Korean:
        return 9; //UTC +09
      case Timezone.Vietnamese:
        return 7; //UTC +07
    }
  }

  //INT(x) để lấy số nguyên lớn nhất không vượt quá x
  static int INT(double value) {
    return value.floor();
  }

  //Chuyển đổi ngày tháng năm -> số ngày Julius
  static int jdFromDate(int dd, int mm, int yy) {
    var a, y, m, jd;
    a = INT((14 - mm) / 12);
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd +
        INT((153 * m + 2) / 5) +
        365 * y +
        INT(y / 4) -
        INT(y / 100) +
        INT(y / 400) -
        32045;
    if (jd < 2299161) {
      jd = dd + INT((153 * m + 2) / 5) + 365 * y + INT(y / 4) - 32083;
    }
    return jd;
  }

  //Chuyển đổi số ngày Julius -> ngày tháng năm
  static List<int> jdToDate(int jd) {
    List<int> result = [0, 0, 0];
    var a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      // After 5/10/1582, Gregorian calendar
      a = jd + 32044;
      b = INT((4 * a + 3) / 146097);
      c = a - INT((b * 146097) / 4);
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = INT((4 * c + 3) / 1461);
    e = c - INT((1461 * d) / 4);
    m = INT((5 * e + 2) / 153);
    day = e - INT((153 * m + 2) / 5) + 1;
    month = m + 3 - 12 * INT(m / 10);
    year = b * 100 + d - 4800 + INT(m / 10);

    result[0] = day;
    result[1] = month;
    result[2] = year;

    return result;
  }

  //Tính ngày Sóc thứ k kể từ điểm Sóc ngày 1/1/1900.
  //Kết quả trả về là số ngày Julius của ngày Sóc cần tìm
  static int getNewMoonDay(int k, int timeZone) {
    var T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat, JdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = pi / 180;
    Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 = Jd1 +
        0.00033 *
            sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    M = 359.2242 +
        29.10535608 * k -
        0.0000333 * T2 -
        0.00000347 * T3; // Sun's mean anomaly
    Mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * T2 +
        0.00001236 * T3; // Moon's mean anomaly
    F = 21.2964 +
        390.67050646 * k -
        0.0016528 * T2 -
        0.00000239 * T3; // Moon's argument of latitude
    C1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr);
    C1 = C1 - 0.0004 * sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 = C1 +
        0.0010 * sin(dr * (2 * F - Mpr)) +
        0.0005 * sin(dr * (2 * Mpr + M));
    if (T < -11) {
      deltat = 0.001 +
          0.000839 * T +
          0.0002261 * T2 -
          0.00000845 * T3 -
          0.000000081 * T * T3;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    ;
    JdNew = Jd1 + C1 - deltat;
    return INT(JdNew + 0.5 + timeZone / 24);
  }

  //Tính tọa độ mặt trời để biết Trung khí nào nằm trong tháng âm lịch nào,
  //Tính xem mặt trời nằm ở khoảng nào trên đường hoàng đạo vào thời điểm bắt đầu một tháng âm lịch:
  //-chia đường hoàng đạo làm 12 phần và đánh số các cung này từ 0 đến 11: từ Xuân phân đến Cốc vũ là 0; từ Cốc vũ đến Tiểu mãn là 1; từ Tiểu mãn đến Hạ chí là 2; v.v..
  //-cho jdn là số ngày Julius của bất kỳ một ngày, phương pháp sau này sẽ trả lại số cung nói trên.
  static int getSunLongitude(jdn, timeZone) {
    var T, T2, dr, M, L0, DL, L;
    T = (jdn - 2451545.5 - timeZone / 24) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 +
        35999.05030 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    L = L0 + DL; // true longitude, degree
    L = L * dr;
    L = L - pi * 2 * (INT(L / (pi * 2))); // Normalize to (0, 2*PI)
    return INT(L / pi * 6);
  }

  //Tìm ngày bắt đầu tháng 11 âm lịch
  //Đông chí thường nằm vào khoảng 19/12-22/12, như vậy trước hết ta tìm ngày Sóc trước ngày 31/12.
  //Nếu tháng bắt đầu vào ngày đó không chứa Đông chí thì ta phải lùi lại 1 tháng nữa.
  static int getLunarMonth11(int yy, int timeZone) {
    var k, off, nm, sunLong;
    off = jdFromDate(31, 12, yy) - 2415021;
    k = INT(off / 29.530588853);
    nm = getNewMoonDay(k, timeZone);
    sunLong = getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  //Xác định tháng nhuận
  //Nếu giữa hai tháng 11 âm lịch (tức tháng có chứa Đông chí) có 13 tháng âm lịch thì năm âm lịch đó có tháng nhuận.
  static int getLeapMonthOffset(int a11, int timeZone) {
    var k, last, arc, i;
    k = INT((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    do {
      last = arc;
      i++;
      arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc != last && i < 14);
    return i - 1;
  }

  //Convert solar day to lunar day
  static List<int> solarToLunar(
      int solarYear, int solarMonth, int solarDay, Timezone timezone) {
    List<int> result = [0, 0, 0, 0];

    var utcValue = getTimeZoneValue(timezone);
    var k,
        dayNumber,
        monthStart,
        a11,
        b11,
        lunarDay,
        lunarMonth,
        lunarYear,
        lunarLeap;
    dayNumber = jdFromDate(solarDay, solarMonth, solarYear);
    k = INT((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = getNewMoonDay(k + 1, utcValue);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, utcValue);
    }
    a11 = getLunarMonth11(solarYear, utcValue);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = solarYear;
      a11 = getLunarMonth11(solarYear - 1, utcValue);
    } else {
      lunarYear = solarYear + 1;
      b11 = getLunarMonth11(solarYear + 1, utcValue);
    }
    lunarDay = dayNumber - monthStart + 1;
    var diff = INT((monthStart - a11) / 29);
    lunarLeap = 0;
    lunarMonth = diff + 11;

    if (b11 - a11 > 365) {
      var leapMonthDiff = getLeapMonthOffset(a11, utcValue);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = 1;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }

    result[0] = lunarDay;
    result[1] = lunarMonth;
    result[2] = lunarYear;
    result[3] = lunarLeap;
    return result;
  }

  static List<int> convertLunar2Solar(int lunarDay, int lunarMonth,
      int lunarYear, int lunarLeap, Timezone timeZone) {
    int a11, b11;

    var utcValue = getTimeZoneValue(timeZone);
    if (lunarMonth < 11) {
      a11 = getLunarMonth11(lunarYear - 1, utcValue);
      b11 = getLunarMonth11(lunarYear, utcValue);
    } else {
      a11 = getLunarMonth11(lunarYear, utcValue);
      b11 = getLunarMonth11(lunarYear + 1, utcValue);
    }
    int k = INT(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    int off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      int leapOff = getLeapMonthOffset(a11, utcValue);
      int leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        return [0, 0, 0];
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    int monthStart = getNewMoonDay(k + off, utcValue);
    return jdToDate(monthStart + lunarDay - 1);
  }

  static String dateTimeToString(DateTime dateTime) {
    try {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_e) {
      return '';
    }
  }

  static String dateTimeToString8(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String dateTimeToString5(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm').format(dateTime);
  }

  static String dateTimeToString6(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateTimeToString7(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateTimeToString2(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  static String dateTimeToStringCustom(DateTime dateTime, String? format) {
    return DateFormat(format ?? 'yyyy/MM/dd').format(dateTime);
  }

  static String dateTimeToString3(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateTimeToString2NodayJapan(DateTime dateTime) {
    return DateFormat('yyyy年MM月dd').format(dateTime);
  }

  static String dateTimeToString2Noday(DateTime dateTime) {
    return DateFormat('yyyy-MM').format(dateTime);
  }

  static String dateTimeToString4(DateTime dateTime) {
    return DateFormat('yyyy/MM').format(dateTime);
  }

  static String dateTimeToString9(DateTime dateTime) {
    return DateFormat('yyyy').format(dateTime);
  }

  static String formatDateTime2(DateTime date) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    } catch (_e) {
      return '';
    }
  }

  static String formatDateTimeNoDay(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime formatStringToDate2(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  }

  static DateTime formatStringToDate4(String date) {
    return DateFormat('HH:mm,dd/MM/yyyy').parse(date);
  }

  static DateTime formatStringToDate6(String date) {
    return DateFormat('yyyy dd/MM').parse(date);
  }

  static DateTime formatStringToDate7(String date) {
    return DateFormat('yyyy-MM-dd HH:mm').parse(date);
  }

  static DateTime formatStringToDate8(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  static String formatDateTime3(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime5(DateTime date) {
    return DateFormat('yyyy/MM/dd HH:mm').format(date);
  }

  static String formatDateTime4(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(date);
  }

  static String formatDateToHour(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDateToNameImage(DateTime date) {
    return DateFormat('yyyyMMddHHmmss').format(date);
  }

  static String formatDateVietNam(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "Thứ 2";
        break;
      case 2:
        dayName = "Thứ 3";
        break;
      case 3:
        dayName = "Thứ 4";
        break;
      case 4:
        dayName = "Thứ 5";
        break;
      case 5:
        dayName = "Thứ 6";
        break;
      case 6:
        dayName = "Thứ 7";
        break;
      case 7:
        dayName = "Chủ nhật";
        break;
    }

    return ((DateFormat('yyyy-MM-dd').format(date)) + "（$dayName）");
  }

  static String formatDateVietNam2(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "Monday".toUpperCase().tr();
        break;
      case 2:
        dayName = "Tuesday";
        break;
      case 3:
        dayName = "Wednesday";
        break;
      case 4:
        dayName = "Thursday";
        break;
      case 5:
        dayName = "Friday";
        break;
      case 6:
        dayName = "Saturday";
        break;
      case 7:
        dayName = "Sunday";
        break;
    }

    return ("$dayName, ${date.day} Tháng ${date.month}");
  }

  static String? formatDateInWeek(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "Thứ 2";
        break;
      case 2:
        dayName = "Thứ 3";
        break;
      case 3:
        dayName = "Thứ 4";
        break;
      case 4:
        dayName = "Thứ 5";
        break;
      case 5:
        dayName = "Thứ 6";
        break;
      case 6:
        dayName = "Thứ 7";
        break;
      case 7:
        dayName = "Chủ nhật";
        break;
    }
    return dayName;
  }

  static String? formatDateStringInWeek(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "Monday";
        break;
      case 2:
        dayName = "Tuesday";
        break;
      case 3:
        dayName = "Wednesday";
        break;
      case 4:
        dayName = "Thursday";
        break;
      case 5:
        dayName = "Friday";
        break;
      case 6:
        dayName = "Saturday";
        break;
      case 7:
        dayName = "Sunday";
        break;
    }
    return dayName;
  }

  static String? formatDateInWeekType2(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "T.Hai";
        break;
      case 2:
        dayName = "T.Ba";
        break;
      case 3:
        dayName = "T.Tư";
        break;
      case 4:
        dayName = "T.Năm";
        break;
      case 5:
        dayName = "T.Sáu";
        break;
      case 6:
        dayName = "T.Bảy";
        break;
      case 7:
        dayName = "CN";
        break;
    }
    return dayName;
  }

  static String formatDateJapan2(DateTime date) {
    return ((DateFormat('MM/dd').format(date)));
  }

  static String formatDateJapan2NoDay(DateTime date) {
    return ((DateFormat('yyyy年MM月').format(date)));
  }

  static DateTime convertStringJapanToDateNoDay(String dateString) {
    DateFormat df2 =
        DateFormat('yyyy年MM月'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertStringJapanToDate(String dateString) {
    DateFormat df2 =
        DateFormat('yyyy-MM-dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertStringToDate4(String dateString) {
    DateFormat df2 = DateFormat(
        'yyyy-MM-dd HH:mm:ss'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertStringToDate5(String dateString) {
    DateFormat df2 =
        DateFormat('yyyy/MM/dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertDateToStringCustom(String dateString, String? format) {
    DateFormat df2 = DateFormat(
        format ?? 'yyyy/MM/dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertDateToString6(String dateString) {
    DateFormat df2 =
        DateFormat('yyyy/MM'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime convertDateToString7(String dateString) {
    DateFormat df2 = DateFormat('yyyy-MM-dd');
    var date;
    try {
      date = df2.parse(dateString);
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      debugPrint(_ex.toString());
    }
    return date;
  }

  static DateTime fromTimeStamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  static DateTime fromTimeStampNoHour(int timestamp) {
    return DateTimeCommon.formatStringToDate8(DateTimeCommon.dateTimeToString(
        DateTime.fromMillisecondsSinceEpoch(timestamp)));
  }

  static String fromTimeStampToString(int? timestamp) {
    if (timestamp != null) {
      return dateTimeToString(fromTimeStamp(timestamp * 1000));
    }
    return "";
  }

  static String fromTimeHourToString(int? timestamp) {
    if (timestamp != null) {
      return dateTimeToString8(fromTimeStamp(timestamp * 1000));
    }
    return "";
  }
}
