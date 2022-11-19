import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/trainer.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/screens/home/trainer_list.dart';
import 'package:pilates_schedule/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Trainer>>.value(
      value: DatabaseServicePerson().trainers,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Text('Pilates schedule'),
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
        body: Scaffold(
          backgroundColor: Colors.pink[50],
          appBar: AppBar(
              title: Text('Haim Levanon 15, Tel-Aviv',
              style:TextStyle(
                color: Colors.pink[900],
                fontSize: 20.0,
              ),
              ),
              backgroundColor: Colors.pink[50],
              elevation: 0.0,
          ),
          body: Container(
            child: TrainerList(),
          ),
        ),
      ),
    );
  }
}