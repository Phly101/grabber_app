import "package:flutter/material.dart";
import "package:table_calendar/table_calendar.dart";

class TableWidget extends StatelessWidget {
  final DateTime today;
  final OnDaySelected? onDaySelected;
  const TableWidget({super.key, required this.today, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      ),calendarBuilders: CalendarBuilders(
      outsideBuilder: (context, day, focusedDay) {

        if (day.month == focusedDay.month + 1 ||
            (focusedDay.month == 12 && day.month == 1)) {
          if (day.day <= 6 ) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  "${day.day}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        }
        if (day.month == focusedDay.month - 1 ||
            (focusedDay.month == 1 && day.month == 12)) {
          if (day.day <= 31) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  "${day.day}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        }


        return Center(
          child: Text(
            "${day.day}",
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    ),
      daysOfWeekVisible: true,
      headerStyle: HeaderStyle(
        titleTextStyle: Theme.of(context).textTheme.titleMedium!,
        formatButtonVisible: false,
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      focusedDay: today,
      selectedDayPredicate: (day)=>isSameDay(day, today),
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2040, 1, 1),
      onDaySelected: onDaySelected,
    );
  }
}
