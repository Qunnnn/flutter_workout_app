import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/components/edit_exercise_widget.dart';
import '../shared/preferences/helpers/format_time.dart';
import '../view_model/cubits/cubits.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  BlocProvider.of<WorkoutCubit>(context).goHome();
                },
              ),
              title: InkWell(
                child: Text(we.workout!.title!),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) {
                    final controller =
                        TextEditingController(text: we.workout!.title);
                    return AlertDialog(
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          label: Text('Workout Title'),
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                Workout renamedTitle = we.workout!
                                    .copyWith(title: controller.text);
                                BlocProvider.of<WorkoutsCubit>(context)
                                    .saveWorkout(
                                        workout: renamedTitle, index: we.index);
                                BlocProvider.of<WorkoutCubit>(context)
                                    .editWorkout(
                                        workout: renamedTitle, index: we.index);
                              }
                            },
                            child: const Text('Save'))
                      ],
                    );
                  },
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = we.workout!.exercises[index];
                if (we.exIndex == index) {
                  return EditExerciseWidget(
                      workout: we.workout,
                      index: we.index,
                      exIndex: we.exIndex);
                }
                return ListTile(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.maximumDensity,
                    vertical: -1.5,
                  ),
                  leading: Text(formatTime(exercise.prelude!)),
                  title: Text(exercise.title!),
                  trailing: Text(formatTime(exercise.duration!)),
                  onTap: () {
                    BlocProvider.of<WorkoutCubit>(context)
                        .editExercise(exIndex: index);
                  },
                );
              },
            ),
          );
        },
      ),
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
    );
  }
}
