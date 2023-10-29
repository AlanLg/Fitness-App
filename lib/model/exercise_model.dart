import 'package:flutter/cupertino.dart';

import '../icons/my_flutter_app_icons.dart';

class ExerciseSetGroup {
  final List<ExerciseSet> sets;
  final Exercise exercise;

  void addSet(ExerciseSet set) {
    sets.add(set);
  }

  Exercise get getExercise {
    return exercise;
  }

  ExerciseSetGroup(this.sets, this.exercise);
}

class ExerciseSet {
  int reps;
  int weight;

  ExerciseSet({required this.reps, required this.weight});
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
