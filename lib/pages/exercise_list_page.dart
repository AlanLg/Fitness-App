import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exercises_cubit.dart';
import '../model/exercise_model.dart';

class ExerciseList extends StatelessWidget {
  ExerciseList({super.key, required this.workoutType});

  final WorkoutType workoutType;
  final List<ExerciseSetGroup> exerciseSets = [];

  void exercises() {
    for (var exercise in workoutType.exercises) {
      exerciseSets
          .add(ExerciseSetGroup([ExerciseSet(reps: 0, weight: 0)], exercise));
    }
  }

  @override
  Widget build(BuildContext context) {
    exercises();
    return BlocBuilder<WorkoutCubit, Map<DateTime, List<ExerciseSetGroup>>>(
        builder: (context, sets) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Exercise List"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  context.read<WorkoutCubit>().add(exerciseSets);
                  Navigator.pop(context);
                },
                child: const Text("Finish")),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: ListView(children: [
          for (ExerciseSetGroup exercise in exerciseSets)
            ExerciseCard(
              set: exercise,
            )
        ]),
      );
    });
  }
}

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.set});

  final ExerciseSetGroup set;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.set.getExercise.name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Divider(),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Set',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Reps',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Weight',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.set.sets.length,
                  (index) => DataRow(cells: <DataCell>[
                    DataCell(Text((index + 1).toString())),
                    DataCell(TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          widget.set.sets[index].reps = int.parse(text);
                        });
                      },
                    )),
                    DataCell(TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          widget.set.sets[index].weight = int.parse(text);
                        });
                      },
                    )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.set.addSet(ExerciseSet(reps: 0, weight: 0));
                    });
                  },
                  child: const Text("+ Add Set"))
            ],
          ),
        ),
      ),
    );
  }
}
