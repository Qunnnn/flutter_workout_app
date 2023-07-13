import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/view_model/cubits/workout_cubit/workout_state.dart';
import 'package:wakelock/wakelock.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  Timer? _timer;
  editWorkout({required Workout workout, required int index}) =>
      emit(WorkoutEditing(workout: workout, index: index, exIndex: null));

  editExercise({required int exIndex}) => emit(WorkoutEditing(
      workout: state.workout,
      index: (state as WorkoutEditing).index,
      exIndex: exIndex));

  goHome() => emit(const WorkoutInitial());

  onTick(Timer timer) {
    if (state is WorkoutProgress) {
      WorkoutProgress wp = state as WorkoutProgress;
      if (wp.elapsed! < wp.workout!.getTotal()) {
        emit(WorkoutProgress(workout: wp.workout!, elapsed: wp.elapsed! + 1));
      } else {
        _timer!.cancel();
         Wakelock.disable();
        emit(const WorkoutInitial());
      }
    }
  }

  startWorkout(Workout workout, int? startTime) {
     Wakelock.enable();
    if (startTime != null) {
      emit(WorkoutProgress(workout: workout, elapsed: startTime));
    } else {
      emit(WorkoutProgress(workout: workout, elapsed: 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  pausedWorkout() =>
      emit(WorkoutPaused(workout: state.workout!, elapsed: state.elapsed));

  resumeWorkout() =>
      emit(WorkoutProgress(workout: state.workout!, elapsed: state.elapsed!));
}
