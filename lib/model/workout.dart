import 'package:equatable/equatable.dart';
import 'package:flutter_workout_app/model/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.title, required this.exercises});

  Workout copyWith({title, exercises}) {
    return Workout(
        title: title ?? this.title, exercises: exercises ?? this.exercises);
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in json['exercises']) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(title: json['title'], exercises: exercises);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'exercises': exercises,
      };
  int getTotal() {
    int time = exercises.fold(
        0,
        (previousValue, element) =>
            previousValue + element.prelude! + element.duration!);
    return time;
  }

  Exercise getCurrentExercise(int? elapsed) =>
      exercises.lastWhere((element) => element.startTime! <= elapsed!);

  @override
  List<Object?> get props => [title, exercises];
  @override
  bool get stringify => true;
}
