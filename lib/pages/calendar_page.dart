import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../main.dart';
import 'exercise_list_page.dart';

//
// class CalendarPage extends StatefulWidget {
//   const CalendarPage({super.key});
//
//   @override
//   State<CalendarPage> createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WorkoutCubit, Map<DateTime, List<ExerciseSetGroup>>>(
//         builder: (context, sets) {
//       return TableCalendar(
//         firstDay: DateTime.utc(2010, 10, 16),
//         lastDay: DateTime.utc(2030, 3, 14),
//         focusedDay: DateTime.now(),
//         eventLoader: (day) {
//           if (!context.read<WorkoutCubit>().contains(day)) {
//             return [];
//           }
//           return context
//               .read<WorkoutCubit>()
//               .get(day)
//               .map((e) => e.getExercise.name)
//               .toList();
//         },
//       );
//     });
//   }
// }
//
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = normalizeDate(DateTime.now());
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<ExerciseSetGroup> _getEventsForDay(DateTime day) {
    // Implementation example
    return context.read<WorkoutCubit>().get(day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<ExerciseSetGroup>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: BlocBuilder<WorkoutCubit,
                Map<DateTime, List<ExerciseSetGroup>>>(
              builder: (context, value) {
                return ListView.builder(
                  itemCount: _getEventsForDay(_focusedDay).length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                            onTap: () => print(
                                _getEventsForDay(_focusedDay)[index]
                                    .getExercise
                                    .name),
                            title: Column(
                              children: [
                                Text(_getEventsForDay(_focusedDay)[index]
                                    .getExercise
                                    .name)
                              ],
                            )));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final kToday = normalizeDate(DateTime.now());
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
