import 'package:flutter/material.dart';
import 'package:pilates_schedule/screens/trainee/trainee_list.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:pilates_schedule/models/trainee.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:provider/provider.dart';

class Trainees extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Trainee>>.value(
      value: DatabaseServicePerson().trainees,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Text('Trainees List'),
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
          child: TraineeList(),
        ),


      ),
    );
  }

}