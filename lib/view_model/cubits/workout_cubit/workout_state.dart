import 'package:equatable/equatable.dart';
import 'package:flutter_workout_app/model/model.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;
  const WorkoutState({required this.workout, required this.elapsed});
}

class WorkoutInitial extends WorkoutState {
  const WorkoutInitial() : super(workout: null, elapsed: 0);
  @override
  List<Object?> get props => [];
}

class WorkoutEditing extends WorkoutState {
  final int index;
  final int? exIndex;
  const WorkoutEditing(
      {required Workout? workout, required this.index, required this.exIndex})
      : super(workout: workout, elapsed: 0);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, index, exIndex];
}

class WorkoutProgress extends WorkoutState {
  const WorkoutProgress({required Workout workout, required int? elapsed})
      : super(workout: workout, elapsed: elapsed);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, elapsed];
}
