import 'package:flutter/material.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/preferences/helpers/format_time.dart';
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
  TextEditingController? _title;
  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
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
                  });
                },
                textMapper: (numberText) => formatTime(int.parse(numberText)),
              ),
            )),
        Expanded(
          flex: 3,
          child: TextField(
            controller: _title,
            textAlign: TextAlign.center,
            onChanged: (value) => setState(() {
              widget.workout!.exercises[widget.exIndex!] = widget
                  .workout!.exercises[widget.exIndex!]
                  .copyWith(title: value);
            }),
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
                  });
                },
                textMapper: (numberText) => formatTime(int.parse(numberText)),
              ),
            ))
      ],
    );
  }
}
