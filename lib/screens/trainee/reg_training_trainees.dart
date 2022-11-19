import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainee.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/screens/trainee/reg_training_trinee_tile.dart';

class RegTrainingTraineeList extends StatefulWidget {
  const RegTrainingTraineeList({Key? key, required this.uidList}) : super(key: key);
  @override
  final List<dynamic> uidList;
  State<RegTrainingTraineeList> createState() => _RegTrainingTraineeListState();
}

class _RegTrainingTraineeListState extends State<RegTrainingTraineeList> {
  @override
  Widget build(BuildContext context) {

    final trainees_uid = Provider.of< List<List>>(context) ?? [];
    return ListView.builder(
      itemCount: trainees_uid.length,
      itemBuilder:(context,index){
        if (widget.uidList.contains(trainees_uid[index][1]))
          {
            return RegTrainingTraineesTile(trainee_name: trainees_uid[index][0].name);
          }
        else{
          return RegTrainingTraineesTile(trainee_name: "");;
        }
      },
    );
  }
}
