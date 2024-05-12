import 'dart:convert';
/// year : 2024
/// month : 5
/// day : 11
/// hour : 18
/// minute : 4
/// seconds : 4
/// milliSeconds : 836
/// dateTime : "2024-05-11T18:04:04.8360131"
/// date : "05/11/2024"
/// time : "18:04"
/// timeZone : "Zulu"
/// dayOfWeek : "Saturday"
/// dstActive : false

TimeZoneModel timeZoneModelFromJson(String str) => TimeZoneModel.fromJson(json.decode(str));
String timeZoneModelToJson(TimeZoneModel data) => json.encode(data.toJson());
class TimeZoneModel {
  TimeZoneModel({
      num? year, 
      num? month, 
      num? day, 
      num? hour, 
      num? minute, 
      num? seconds, 
      num? milliSeconds, 
      String? dateTime, 
      String? date, 
      String? time, 
      String? timeZone, 
      String? dayOfWeek, 
      bool? dstActive,}){
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _seconds = seconds;
    _milliSeconds = milliSeconds;
    _dateTime = dateTime;
    _date = date;
    _time = time;
    _timeZone = timeZone;
    _dayOfWeek = dayOfWeek;
    _dstActive = dstActive;
}

  TimeZoneModel.fromJson(dynamic json) {
    _year = json['year'];
    _month = json['month'];
    _day = json['day'];
    _hour = json['hour'];
    _minute = json['minute'];
    _seconds = json['seconds'];
    _milliSeconds = json['milliSeconds'];
    _dateTime = json['dateTime'];
    _date = json['date'];
    _time = json['time'];
    _timeZone = json['timeZone'];
    _dayOfWeek = json['dayOfWeek'];
    _dstActive = json['dstActive'];
  }
  num? _year;
  num? _month;
  num? _day;
  num? _hour;
  num? _minute;
  num? _seconds;
  num? _milliSeconds;
  String? _dateTime;
  String? _date;
  String? _time;
  String? _timeZone;
  String? _dayOfWeek;
  bool? _dstActive;
TimeZoneModel copyWith({  num? year,
  num? month,
  num? day,
  num? hour,
  num? minute,
  num? seconds,
  num? milliSeconds,
  String? dateTime,
  String? date,
  String? time,
  String? timeZone,
  String? dayOfWeek,
  bool? dstActive,
}) => TimeZoneModel(  year: year ?? _year,
  month: month ?? _month,
  day: day ?? _day,
  hour: hour ?? _hour,
  minute: minute ?? _minute,
  seconds: seconds ?? _seconds,
  milliSeconds: milliSeconds ?? _milliSeconds,
  dateTime: dateTime ?? _dateTime,
  date: date ?? _date,
  time: time ?? _time,
  timeZone: timeZone ?? _timeZone,
  dayOfWeek: dayOfWeek ?? _dayOfWeek,
  dstActive: dstActive ?? _dstActive,
);
  num? get year => _year;
  num? get month => _month;
  num? get day => _day;
  num? get hour => _hour;
  num? get minute => _minute;
  num? get seconds => _seconds;
  num? get milliSeconds => _milliSeconds;
  String? get dateTime => _dateTime;
  String? get date => _date;
  String? get time => _time;
  String? get timeZone => _timeZone;
  String? get dayOfWeek => _dayOfWeek;
  bool? get dstActive => _dstActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = _year;
    map['month'] = _month;
    map['day'] = _day;
    map['hour'] = _hour;
    map['minute'] = _minute;
    map['seconds'] = _seconds;
    map['milliSeconds'] = _milliSeconds;
    map['dateTime'] = _dateTime;
    map['date'] = _date;
    map['time'] = _time;
    map['timeZone'] = _timeZone;
    map['dayOfWeek'] = _dayOfWeek;
    map['dstActive'] = _dstActive;
    return map;
  }

}