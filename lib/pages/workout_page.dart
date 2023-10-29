import 'package:workout_app/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/pages/exercise_list_page.dart';

class WorkoutSelectionPage extends StatefulWidget {
  const WorkoutSelectionPage({super.key});

  @override
  State<WorkoutSelectionPage> createState() => _WorkoutSelectionPageState();
}

class _WorkoutSelectionPageState extends State<WorkoutSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              const Text(
                "Workout Options",
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WorkoutBox(
              workoutType: WorkoutType.push,
            ),
            WorkoutBox(
              workoutType: WorkoutType.pull,
            ),
            WorkoutBox(
              workoutType: WorkoutType.legs,
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              const Text(
                "Previous Session",
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.width * 0.18,
                          child: const Card(
                            color: Colors.grey,
                            child: Icon(
                              WorkoutIcons.dumbbell,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Column(
                        children: [
                          Text("Previous Session Stats"),
                          Text("Push Workout"),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text("Workout Date: "),
                      Text("11/10/2023"),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Row(
                    children: [
                      Text("Time Spent: "),
                      Text("50m"),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Row(
                    children: [
                      Text("Rest Time: "),
                      Text("10m"),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Row(
                    children: [
                      Text("Rest Time: "),
                      Text("10m"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WorkoutBox extends StatelessWidget {
  final WorkoutType workoutType;

  const WorkoutBox({super.key, required this.workoutType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseList(
                    workoutType: workoutType,
                  )),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Icon(
                workoutType.icon,
                size: MediaQuery.of(context).size.width * 0.2,
                color: Theme.of(context).iconTheme.color,
              ),
              Text(workoutType.niceName),
            ],
          ),
        ),
      ),
    );
  }
}

enum WorkoutType {
  push(
    icon: WorkoutIcons.push,
    niceName: "Push",
    exercises: <Exercise>[
      Exercise("Bench press"),
      Exercise("Dumbbell bench press"),
      Exercise("Dip"),
      Exercise("Tricep pushdowns"),
    ],
  ),
  pull(
    icon: WorkoutIcons.pull,
    niceName: "Pull",
    exercises: <Exercise>[
      Exercise("Pull-up"),
      Exercise("Bent-over row"),
      Exercise("Pull-down"),
      Exercise("Pull-down"),
      Exercise("Bicep curl"),
      Exercise("Cable curl"),
    ],
  ),
  legs(
    icon: WorkoutIcons.legs,
    niceName: "Legs",
    exercises: <Exercise>[
      Exercise("Split squats"),
      Exercise("Squat"),
      Exercise("Leg press"),
    ],
  );

  const WorkoutType({
    required this.icon,
    required this.niceName,
    required this.exercises,
  });

  final IconData icon;
  final String niceName;
  final List<Exercise> exercises;
}

class Exercise {
  final String name;

  const Exercise(this.name);
}
