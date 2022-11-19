import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/training.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilates_schedule/screens/trainee/show_registerd_trainees.dart';


class TrainingDeleteList extends StatefulWidget {
  @override
  State<TrainingDeleteList> createState() => _TrainingDeleteListState();
}

class _TrainingDeleteListState extends State<TrainingDeleteList> {
  static final instance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {

    void _showRegisteredTrainees(int index, var trainings){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: ShowRegTrainees(date:trainings[index].date,day:trainings[index].day,
            hour: trainings[index].hour,uidList: trainings[index].trainees,),
        );
      });
    }

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
                    child:  Row(
                      children: <Widget>[
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: Colors.pink[900],
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white,),
                          ),
                          onPressed: () async{
                              instance.collection('trainings').doc(trainings[index].u).delete();
                          },
                        ),
                        SizedBox(width: 8.0,),
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: Colors.pink[900],
                          ),
                          child: Text(
                            'Show trainees',
                            style: TextStyle(color: Colors.white,),
                          ),
                          onPressed: () async{
                            _showRegisteredTrainees(index, trainings);
                            // Navigator.pop(context, MaterialPageRoute(
                            //   builder: (context)=>ShowRegTrainees(date:trainings[index].date,day:trainings[index].day,
                            //   hour: trainings[index].hour,uidList: trainings[index].trainees,),
                            // ));
                          },
                        ),
                      ],
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
