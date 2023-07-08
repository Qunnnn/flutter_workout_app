import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/view/home_page.dart';
import 'package:flutter_workout_app/view_model/workouts_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      home: BlocProvider<WorkoutsCubit>(
        create: (context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            print('...loading json when state is emty...');
            workoutsCubit.getWorkouts();
          } else {
            print('...the state is not empty...');
          }
          return workoutsCubit;
        },
        child: const HomePage(),
      ),
    );
  }
}
