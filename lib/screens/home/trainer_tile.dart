import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainer.dart';

class TrainerTile extends StatelessWidget {

  final Trainer trainer;
  TrainerTile({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top:8.0),
    child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${trainer.gender}.png'),
              radius: 25.0,
              backgroundColor: Colors.pink[100],
              ),
              title: Text(trainer.name,
                style: TextStyle(fontSize: 18.0,),),
              subtitle: Text('Phone number : ${trainer.phoneNumber} ',
                style: TextStyle(fontSize: 16.0,),),
          ),
      ),
    );
  }
}
