import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainee.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/screens/trainee/trainee_tile.dart';

class TraineeList extends StatefulWidget {
  @override
  State<TraineeList> createState() => _TraineeListState();
}

class _TraineeListState extends State<TraineeList> {
  @override
  Widget build(BuildContext context) {

    final trainees = Provider.of< List<Trainee>>(context) ?? [];
    return ListView.builder(
      itemCount: trainees.length,
      itemBuilder:(context,index){
        return TraineeTile(trainee: trainees[index]);
      },
    );
  }
}
