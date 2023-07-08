import 'package:equatable/equatable.dart';
import 'package:flutter_workout_app/model/exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.title, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in json['exercises']) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime = exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(title: json['title'], exercises: exercises);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'exercises': exercises,
      };

  // @override
  // List<Object?> get props => [title, exercises];
  // @override
  // bool get stringify => true;
}
