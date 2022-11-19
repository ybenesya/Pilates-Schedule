import 'package:flutter/material.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:provider/provider.dart';
import 'reg_training_trainees.dart';

class ShowRegTrainees extends StatefulWidget {
  const ShowRegTrainees({Key? key, required this.date, required this.day, required this.hour,
  required this.uidList}) : super(key: key);
  final String date;
  final String day;
  final String hour;
  final List<dynamic> uidList;
  @override
  State<ShowRegTrainees> createState() => _ShowRegTraineesState();
}

class _ShowRegTraineesState extends State<ShowRegTrainees> {
  @override
  Widget build(BuildContext context){

    return StreamProvider<List<List>>.value(
      value: DatabaseServicePerson().trainees_reg,
      child: Scaffold(
        body: RegTrainingTraineeList(uidList:widget.uidList),
        ),
      );

  }
}

