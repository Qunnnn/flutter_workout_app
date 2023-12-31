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
        'exerciseTitle': exercise.title,
        'nextExerciseTitle': exercise.index! == workout.exercises.length - 1
            ? 'No more'
            : workout.exercises[exercise.index! + 1].title,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,
                  value: stats['workoutProgress'],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'])),
                      DotsIndicator(
                        dotsCount: stats['totalExercise'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text('-' + formatTime(stats['workoutRemaining'])),
                    ],
                  ),
                ),
                const Spacer(),
                stats['isPrelude']
                    ? Column(
                        children: [
                          const Text(
                            'Get ready for:',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          Text(
                            stats['exerciseTitle'],
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Text(
                        stats['exerciseTitle'],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                const SizedBox(
                  height: 150,
                ),
                InkWell(
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: [
                      Center(
                        child: SizedBox(
                          height: 210,
                          width: 210,
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
                        child: InkWell(
                          onTap: () {
                            if (state is WorkoutProgress) {
                              BlocProvider.of<WorkoutCubit>(context)
                                  .pausedWorkout();
                            } else if (state is WorkoutPaused) {
                              BlocProvider.of<WorkoutCubit>(context)
                                  .resumeWorkout();
                            }
                          },
                          child: SizedBox(
                            height: 288,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset('assets/stopwatch.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Next exercise: ${stats['nextExerciseTitle']}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
