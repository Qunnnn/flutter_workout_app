import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/view_model/cubits/workout_cubit/workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkout({required Workout workout, required int index}) =>
      emit(WorkoutEditing(workout: workout, index: index, exIndex: null));

  editExercise({required int exIndex}) => emit(WorkoutEditing(
      workout: state.workout,
      index: (state as WorkoutEditing).index,
      exIndex: exIndex));

  goHome() => emit(const WorkoutInitial());
}
