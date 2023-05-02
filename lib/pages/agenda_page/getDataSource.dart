//calendar library
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

 List<Meeting> getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 10);
  final DateTime endTime = startTime.add(const Duration(hours: 1));

  //Check-in
  meetings.add(Meeting(
      'Check-in', startTime, startTime, const Color(0xFF0F8644), false));

  //Sponsor-Fair
  meetings.add(Meeting(
      'Sponsor Fair',
      DateTime(today.year, today.month, today.day, 10),
      DateTime(today.year, today.month, today.day, 11, 15),
      Color.fromARGB(255, 73, 23, 188),
      false));

  //Opening Ceremony
  meetings.add(Meeting(
      'Opening Ceremony',
      DateTime(today.year, today.month, today.day, 11, 15),
      endTime.add(const Duration(hours: 1)),
      Color.fromARGB(255, 73, 23, 188),
      false));

  //Lunch
  meetings.add(Meeting(
      'Lunch/Team Formation',
      DateTime(today.year, today.month, today.day, 12),
      DateTime(today.year, today.month, today.day, 13),
      Color.fromARGB(255, 73, 23, 188),
      false));

  //ML With Google Cloud Workshop
  meetings.add(Meeting(
      'ML With Google Cloud /Make Your Own Chatbot Workshop',
      DateTime(today.year, today.month, today.day, 14),
      DateTime(today.year, today.month, today.day, 15),
      Color.fromARGB(255, 73, 23, 188),
      false));

  //Intro to Flutter/Sponsor Workshop
  meetings.add(Meeting(
      'Intro to Flutter/Sponsor Workshop',
      DateTime(today.year, today.month, today.day, 16),
      DateTime(today.year, today.month, today.day, 17),
      Color.fromARGB(255, 73, 23, 188),
      false));

  return meetings;
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}