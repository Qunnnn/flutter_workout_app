import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workout_app/model/model.dart';
import 'package:flutter_workout_app/shared/preferences/helpers/format_time.dart';
import 'package:flutter_workout_app/view_model/blocs/workouts_cubit/workouts_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time!'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event_available)),
          IconButton(onPressed: null, icon: Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return ExpansionPanelList.radio(
              children: state
                  .map((workout) => ExpansionPanelRadio(
                      value: workout,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          // visualDensity: const VisualDensity(
                          //   horizontal: 0,
                          //   vertical: VisualDensity.maximumDensity,
                          // ),
                          leading: const IconButton(
                              onPressed: null, icon: Icon(Icons.edit)),
                          title: Text(workout.title!),
                          trailing: Text(
                            formatTime(workout.getTotal()),
                          ),
                        );
                      },
                      body: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: workout.exercises.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.maximumDensity,
                              vertical: -1.5,
                            ),
                            leading: Text(
                                formatTime(workout.exercises[index].prelude!)),
                            title: Text(workout.exercises[index].title!),
                            trailing: Text(
                                formatTime(workout.exercises[index].duration!)),
                          );
                        },
                      )))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
