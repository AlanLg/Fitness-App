import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/exercise_model.dart';
import '../util/workout_util.dart';

class WorkoutCubit extends Cubit<Map<DateTime, List<ExerciseSetGroup>>> {
  WorkoutCubit()
      : super(LinkedHashMap(
          equals: isSameDay,
          hashCode: getHashCode,
        ));

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
