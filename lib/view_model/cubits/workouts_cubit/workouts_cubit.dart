import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
  WorkoutsCubit() : super([]);
  getWorkouts() async {
    final List<Workout> workouts = [];
    final workoutsJson =
        jsonDecode(await rootBundle.loadString('assets/workouts.json'));
    for (var el in workoutsJson) {
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }

  saveWorkout({required Workout workout, required int index}) {
    Workout newWorkout =
        Workout(title: workout.title, exercises: workout.exercises);
    state[index] = newWorkout;
    emit(state);
  }
}
