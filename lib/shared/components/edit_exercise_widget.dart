import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/preferences/helpers/format_time.dart';
import 'package:flutter_workout_app/view_model/cubits/cubits.dart';
import 'package:numberpicker/numberpicker.dart';

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
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              child: NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: widget.workout!.exercises[widget.exIndex!].prelude!,
                onChanged: (value) {
                  setState(() {
                    widget.workout!.exercises[widget.exIndex!] = widget
                        .workout!.exercises[widget.exIndex!]
                        .copyWith(prelude: value);
                    BlocProvider.of<WorkoutsCubit>(context).saveWorkout(
                        workout: widget.workout!, index: widget.index);
                  });
                },
                textMapper: (numberText) => formatTime(int.parse(numberText)),
              ),
            )),
        Expanded(
          flex: 3,
          child: InkWell(
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
                            widget.workout!.exercises[widget.exIndex!] = widget
                                .workout!.exercises[widget.exIndex!]
                                .copyWith(title: controller.text);
                            BlocProvider.of<WorkoutsCubit>(context).saveWorkout(
                                workout: widget.workout!, index: widget.index);
                            BlocProvider.of<WorkoutCubit>(context).editWorkout(
                                workout: widget.workout!, index: widget.index);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'))
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              child: NumberPicker(
                minValue: 0,
                maxValue: 3599,
                value: widget.workout!.exercises[widget.exIndex!].duration!,
                onChanged: (value) {
                  setState(() {
                    widget.workout!.exercises[widget.exIndex!] = widget
                        .workout!.exercises[widget.exIndex!]
                        .copyWith(duration: value);
                    BlocProvider.of<WorkoutsCubit>(context).saveWorkout(
                        workout: widget.workout!, index: widget.index);
                  });
                },
                textMapper: (numberText) => formatTime(int.parse(numberText)),
              ),
            ))
      ],
    );
  }
}
