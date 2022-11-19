import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/training.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilates_schedule/models/person.dart';


class TrainingList extends StatefulWidget {
  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  static final instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    String user_uid = user.uid;

    final trainings = Provider.of< List<TrainingData>>(context) ?? [];

    return ListView.builder(
      itemCount: trainings.length,
      itemBuilder:(context,index){
        return Padding(
          padding: EdgeInsets.only(top:8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              title: Text(trainings[index].date,
                style: TextStyle(fontSize: 18.0,),),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Day: ${trainings[index].day}\nHour: ${trainings[index].hour}\n'
                        'Trainer: ${trainings[index].trainer}\nNumber of registered trainees : ${trainings[index].num_trainees}',
                      style: TextStyle(fontSize: 16.0,),),
                  ),
                  SizedBox(height: 5.0,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Colors.pink[900],
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white,),
                      ),
                      onPressed: () async{
                        if (trainings[index].max_num_trainee > trainings[index].num_trainees && trainings[index].trainees.contains(user_uid) == false){
                          instance.collection('trainings').doc(trainings[index].u).update({'num_trainees': trainings[index].num_trainees + 1});
                          instance.collection('trainings').doc(trainings[index].u).update({'trainees': trainings[index].trainees + [user_uid]});
                        }
                        else{
                          String error1 ="";
                          String error2 ="";
                          if (trainings[index].max_num_trainee < trainings[index].num_trainees){
                            error1 = 'The training is full';
                          }
                          if(trainings[index].trainees.contains(user_uid)){
                            error2 =' You already sign up for this class';
                          }

                          AlertDialog alert = AlertDialog(
                            title: Text(error1+error2),
                            actions: [
                            ],
                          );
                          showDialog(context: context, builder: (BuildContext context){return alert;});
                        }

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

