import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainer.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/screens/home/trainer_tile.dart';

class TrainerList extends StatefulWidget {
  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  @override
  Widget build(BuildContext context) {

    final trainers = Provider.of< List<Trainer>>(context) ?? [];
    return ListView.builder(
      itemCount: trainers.length,
      itemBuilder:(context,index){
        return TrainerTile(trainer: trainers[index]);
      },
    );
  }
}
