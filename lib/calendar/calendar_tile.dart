import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './date_utils.dart';
import './neat_and_clean_calendar_event.dart';

class NeatCleanCalendarTile extends StatelessWidget {
  final VoidCallback? onDateSelected;
  final DateTime? date;
  final String? dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List<NeatCleanCalendarEvent>? events;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final Widget? child;
  final Color? defaultDayColor;
  final Color? defaultOutOfMonthDayColor;
  final Color? selectedColor;
  final Color? selectedTodayColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;
//
  NeatCleanCalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek = false,
    this.isSelected = false,
    this.inMonth = true,
    this.events,
    this.defaultDayColor,
    this.defaultOutOfMonthDayColor,
    this.selectedColor,
    this.selectedTodayColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek ?? '',
            style: dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected, // react on tapping
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: isSelected && date != null
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColor != null
                        ? Utils.isSameDay(date!, DateTime.now())
                            ? selectedTodayColor ?? Colors.red
                            : selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : const BoxDecoration(), // no decoration when not selected
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Date display
                Text(
                  date != null ? DateFormat("d").format(date!) : '',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: isSelected && date != null
                          ? Colors.white
                          : Utils.isSameDay(date!, DateTime.now())
                              ? todayColor
                              : inMonth
                                  ? defaultDayColor ?? Colors.black
                                  : (defaultOutOfMonthDayColor ?? Colors.grey)),
                ),
                //TODO Dots for the events
                events != null && events!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events!.map((event) {
                          eventCount++;
                          // Show a maximum of 3 dots.
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 1.0),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (() {
                                  if (isSelected) return Colors.white;
                                  return eventColor ??
                                      event.color ??
                                      Theme.of(context).colorScheme.secondary;
                                }())),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO If a child widget was passed as parameter, this widget gets used to be rendered to display weekday or date
    if (child != null) {
      return InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
