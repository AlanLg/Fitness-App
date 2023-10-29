import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/icons/my_flutter_app_icons.dart';
import 'package:workout_app/pages/calendar_page.dart';
import 'package:workout_app/pages/exercise_list_page.dart';
import 'package:workout_app/pages/workout_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      create: (context) => WorkoutCubit(),
      child: MaterialApp(
          title: 'Fitness App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'My Fitness App')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    const CalendarPage(),
    const WorkoutSelectionPage(),
    const WorkoutSelectionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          Icon(Icons.more_vert),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(WorkoutIcons.dumbbell), label: "Workout"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}

class WorkoutCubit extends Cubit<Map<DateTime, List<ExerciseSetGroup>>> {
  WorkoutCubit()
      : super(LinkedHashMap(
          equals: isSameDay,
          hashCode: getHashCode,
        ));

  static get getHashCode => null;

  Iterable<DateTime> getAll() {
    return state.keys;
  }

  List<ExerciseSetGroup> get(DateTime dateTime) {
    return state[dateTime] ?? [];
  }

  bool contains(DateTime dateTime) {
    return state.containsKey(dateTime);
  }

  void add(List<ExerciseSetGroup> exercises) {
    state.putIfAbsent(normalizeDate(DateTime.now()), () => exercises);
    emit(state);
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
