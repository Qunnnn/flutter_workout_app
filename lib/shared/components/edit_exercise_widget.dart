import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/preferences/helpers/format_time.dart';
import 'package:flutter_workout_app/view_model/cubits/cubits.dart';
// import 'package:numberpicker/numberpicker.dart';

class EditExerciseWidget extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;
  const EditExerciseWidget(
      {super.key,
      required this.workout,
      required this.index,
      required this.exIndex});

  @override
  State<EditExerciseWidget> createState() => _EditExerciseWidgetState();
}

class _EditExerciseWidgetState extends State<EditExerciseWidget> {
  // TextEditingController? _title;
  @override
  void initState() {
    // _title = TextEditingController(
    //     text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                final controller = TextEditingController(
                    text: widget.workout!.exercises[widget.exIndex!].prelude!
                        .toString());
                return AlertDialog(
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Adjustment'),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            setState(() {
                              widget.workout!.exercises[widget.exIndex!] =
                                  widget.workout!.exercises[widget.exIndex!]
                                      .copyWith(
                                          prelude: int.parse(controller.text));
                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Save'))
                  ],
                );
              },
            ),
            child: Text(
              formatTime(widget.workout!.exercises[widget.exIndex!].prelude!),
            ),
          ),
          InkWell(
            child: Center(
                child: Text(widget.workout!.exercises[widget.exIndex!].title!)),
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                final controller = TextEditingController(
                    text: widget.workout!.exercises[widget.exIndex!].title);
                return AlertDialog(
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      label: Text('Adjustment'),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            setState(() {
                              widget.workout!.exercises[widget.exIndex!] =
                                  widget.workout!.exercises[widget.exIndex!]
                                      .copyWith(title: controller.text);
                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Save'))
                  ],
                );
              },
            ),
          ),
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                final controller = TextEditingController(
                    text: widget.workout!.exercises[widget.exIndex!].duration!
                        .toString());
                return AlertDialog(
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Adjustment'),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            setState(() {
                              widget.workout!.exercises[widget.exIndex!] =
                                  widget.workout!.exercises[widget.exIndex!]
                                      .copyWith(
                                          duration: int.parse(controller.text));
                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(
                                      workout: widget.workout!,
                                      index: widget.index);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Save'))
                  ],
                );
              },
            ),
            child: Text(
              formatTime(widget.workout!.exercises[widget.exIndex!].duration!),
            ),
          ),
        ],
      ),
    );
  }
}
