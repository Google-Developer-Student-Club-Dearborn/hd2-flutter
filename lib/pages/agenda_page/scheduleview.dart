import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hd2_app/pages/agenda_page/getDataSource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hd2_app/pages/agenda_page/eventexpand.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    void calendarTapped(CalendarTapDetails calendarTapDetails){
      int index = calendarTapDetails.appointments!.indexOf(calendarTapDetails.appointments![0]);
    if (calendarTapDetails.targetElement == CalendarElement.appointment){
    Meeting appointment = calendarTapDetails.appointments![0];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute(appointment:appointment)),
    );
  }
  }
    return SfCalendar(
      view: CalendarView.schedule,
      dataSource: MeetingDataSource(getDataSource()),
      scheduleViewSettings: ScheduleViewSettings(
        appointmentItemHeight: 70,
      ),
      showCurrentTimeIndicator: true,
      todayHighlightColor: Color.fromARGB(0, 184, 240, 14),
      onTap: calendarTapped,
    );
  }

}