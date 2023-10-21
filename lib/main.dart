import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/icons/my_flutter_app_icons.dart';
import 'package:workout_app/pages/calendarpage.dart';
import 'package:workout_app/pages/workoutpage.dart';

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

    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Fitness App'),
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
  Widget bodyWidget = const WorkoutSelectionPage();
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
          switch (index) {
            case 0:
              setState(() {
                bodyWidget = const CalendarPage();
              });
              break;
            case 1:
            case 2:
              setState(() {
                bodyWidget = const WorkoutSelectionPage();
              });
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(WorkoutIcons.dumbbell), label: "Workout"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      body: bodyWidget,
    );
  }
}