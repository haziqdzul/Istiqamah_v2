import 'package:flutter/material.dart';

enum MultiDaySegement {
  first,
  middle,
  last,
}

class NeatCleanCalendarEvent {
  String summary;
  String description;
  String location;
  DateTime startTime;
  DateTime endTime;
  Color? color;
  bool isAllDay;
  bool isMultiDay;
  MultiDaySegement? multiDaySegement;
  bool isDone;

  NeatCleanCalendarEvent(this.summary,
      {this.description = '',
      this.location = '',
      required this.startTime,
      required this.endTime,
      this.color = Colors.orange,
      this.isAllDay = false,
      this.isMultiDay = false,
      this.isDone = false,
      multiDaySegement});
}
