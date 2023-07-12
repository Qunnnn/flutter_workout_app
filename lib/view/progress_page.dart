import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/preferences/helpers/format_time.dart';
import 'package:flutter_workout_app/view_model/cubits/cubits.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;
      int exerciseRemaining = exercise.prelude! - exerciseElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;
      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseRemaining += exercise.duration!;
      }
      return {
        'workoutTitle': workout.title,
        'workoutProgress': workoutElapsed / workoutTotal,
        'workoutElapsed': workoutElapsed,
        'totalExercise': workout.exercises.length,
        'currentExerciseIndex': exercise.index,
        'workoutRemaining': workoutTotal - workoutElapsed,
        'exerciseRemaining': exerciseRemaining,
        'exerciseProgress': exerciseElapsed / exerciseTotal,
        'isPrelude': isPrelude,
      };
    }

    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final stats = getStats(state.workout!, state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title: Text(state.workout!.title.toString()),
            leading: BackButton(
              onPressed: () {
                BlocProvider.of<WorkoutCubit>(context).goHome();
              },
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,
                  value: stats['workoutProgress'],
                ),
                DotsIndicator(
                  dotsCount: stats['totalExercise'],
                  position: stats['currentExerciseIndex'],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'])),
                      Text('-' + formatTime(stats['workoutRemaining'])),
                    ],
                  ),
                ),
                Text(stats['currentExerciseIndex'].toString()),
                const Spacer(),
                InkWell(
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: [
                      Center(
                        child: SizedBox(
                          height: 220,
                          width: 220,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              stats['isPrelude'] ? Colors.red : Colors.blue,
                            ),
                            strokeWidth: 25,
                            value: stats['exerciseProgress'],
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 320,
                          width: 320,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image.asset('assets/stopwatch.png'),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(stats['exerciseProgress'].toString()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
