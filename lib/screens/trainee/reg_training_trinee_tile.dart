import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainee.dart';

class RegTrainingTraineesTile extends StatelessWidget {

  final String trainee_name;
  RegTrainingTraineesTile({required this.trainee_name});

  @override
  Widget build(BuildContext context) {
    if(trainee_name == "")
      {
        return SizedBox(height: 0.0,);
      }
    return Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(trainee_name,
            style: TextStyle(fontSize: 18.0,),),
        ),

    );
  }
}
