import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainee.dart';

class TraineeTile extends StatelessWidget {

  final Trainee trainee;
  TraineeTile({required this.trainee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/${trainee.gender}.png'),
            radius: 25.0,
            backgroundColor: Colors.pink[100],
          ),
          title: Text(trainee.name,
            style: TextStyle(fontSize: 18.0,),),
          subtitle: Text('Age: ${trainee.age}\nLevel: ${trainee.level}\nPhone number : ${trainee.phoneNumber} ',
            style: TextStyle(fontSize: 18.0,),),
        ),
      ),
    );
  }
}
