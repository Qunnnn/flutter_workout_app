import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/model/workout.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class WorkoutsCubit extends HydratedCubit<List<Workout>> {
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

  // saveWorkout({required Workout workout, required int index}) {
  //   Workout newWorkout = Workout(title: workout.title, exercises: []);
  //   int exIndex = 0;
  //   int startTime = 0;
  //   for (var el in workout.exercises) {
  //     newWorkout.exercises.add(Exercise(
  //         title: el.title,
  //         prelude: el.prelude,
  //         duration: el.duration,
  //         index: exIndex,
  //         startTime: startTime));
  //     exIndex++;
  //     startTime = el.prelude! + el.duration!;
  //   }
  //   state[index] = newWorkout;
  //   emit(state);
  // }

  saveWorkout({required Workout workout, required int index}) {
    Workout newWorkout =
        Workout(title: workout.title, exercises: workout.exercises);
    state[index] = newWorkout;
    emit(state);
  }
  @override
  List<Workout> fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    List<Workout> workouts = [];
    json['workouts'].forEach((el) => workouts.add(Workout.fromJson(el)));
    return workouts;
  }

  @override
  Map<String, dynamic> toJson(List<Workout> state) {
    // TODO: implement toJson
    var json = {'workouts': []};
    for (var workout in state) {
      json['workouts']?.add(workout.toJson());
    }
    return json;
  }
}
