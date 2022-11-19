import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/training.dart';
import 'package:pilates_schedule/screens/training/training_delete_list.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:provider/provider.dart';

// This page is for trainer to see all the trainings , and delete training if they want

class DeleteTraining extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<TrainingData>>.value(
      value: DatabaseServiceTraining().trainings,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Text('Trainings Schedual'),
          backgroundColor: Colors.pink[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.grey),
              ),
              onPressed: () async{
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
          child: TrainingDeleteList(),
        ),


      ),
    );
  }

}