import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/models/trainee.dart';
import 'package:pilates_schedule/models/trainer.dart';
import 'package:pilates_schedule/models/training.dart';


class DatabaseServiceTraining{
  final String? uid ;
  DatabaseServiceTraining({this.uid});

  final  CollectionReference trainingCollection = FirebaseFirestore.instance.collection('trainings');


  Future updateTrainingData(String date, String day, String hour, int num_trainees,String u, String trainer_name) async{
    return await trainingCollection.doc(uid).set({
      'date': date,
      'day': day,
      'hour': hour,
      'num_trainees': num_trainees,
      'max_num_trainee': 7,
      'trainees':[],
      'u': u,
      'trainer': trainer_name,
    });
  }

  //get trainees stream
  Stream< List<TrainingData>> get trainings {
    return trainingCollection.snapshots().map((_trainingListFromSnapshot));
  }


  // create trainee list
  List<TrainingData> _trainingListFromSnapshot(QuerySnapshot snapshot){
    List<TrainingData> training_list = [];
    for (var value in snapshot.docs){
        training_list.add(TrainingData(day: value.get('day'), date: value.get('date'),
            hour: value.get('hour'),num_trainees: value.get('num_trainees'), u: value.get('u'), trainer: value.get('trainer'),
            trainees: value.get('trainees')));

    }
    return training_list;
  }

  void deleteTraining(){

  }


}

class DatabaseServicePerson {

  final String? uid ;
  DatabaseServicePerson({this.uid});

  // collection reference
  final  CollectionReference personsCollection = FirebaseFirestore.instance.collection('persons');

  Future updatePersonData(String name, String phoneNumber, String gender, bool isTrainer, String age, String level) async{
    return await personsCollection.doc(uid).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'isTrainer': isTrainer,
      'age' : age,
      'level': level,
    });
  }

  // create trainer list
  List<Trainer> _trainerListFromSnapshot(QuerySnapshot snapshot){
    List<Trainer> trainer_list = [];
    for (var value in snapshot.docs){
      if (value.get('isTrainer') == true)
        {
          trainer_list.add(Trainer(name: value.get('name'), phoneNumber: value.get('phoneNumber'), gender: value.get('gender')));
        }
    }
    return trainer_list;
  }


  //get trainees stream
  Stream< List<List>> get trainees_reg {
    return personsCollection.snapshots().map((_traineeRegListFromSnapshot));
  }

  // create trainee list
  List<List> _traineeRegListFromSnapshot(QuerySnapshot snapshot){
    List<List> trainee_list = [];
    for (var value in snapshot.docs){
      if (value.get('isTrainer') == false)
      {
        trainee_list.add([Trainee(name: value.get('name'), age: value.get('age'),
            level: value.get('level'),phoneNumber: value.get('phoneNumber'), gender: value.get('gender')),value.id]);
      }
    }
    return trainee_list;
  }



  // create trainee list
  List<Trainee> _traineeListFromSnapshot(QuerySnapshot snapshot){
    List<Trainee> trainee_list = [];
    for (var value in snapshot.docs){
      if (value.get('isTrainer') == false)
      {
          trainee_list.add(Trainee(name: value.get('name'), age: value.get('age'),
              level: value.get('level'),phoneNumber: value.get('phoneNumber'), gender: value.get('gender')));
      }
    }
    return trainee_list;
  }


  //get trainers stream
  Stream< List<Trainer>> get trainers {
    return personsCollection.snapshots().map((_trainerListFromSnapshot));
  }

  //get trainees stream
  Stream< List<Trainee>> get trainees {
    return personsCollection.snapshots().map((_traineeListFromSnapshot));
  }


  Future <List<dynamic>> getNamesList(List<dynamic> uidList) async{
    List<dynamic> names = [];
    String name ;
    for (var u in uidList){
      DocumentReference documentReference = personsCollection.doc(u);
      await documentReference.get().then((value) {
        name = value!.get('name').toString();
        names.add(name);
      }) ;
    }
    return names;
  }



  PersonData _personDataFromSnapshot(DocumentSnapshot snapshot){
    return PersonData(
        uid: uid!,
        phoneNumber: snapshot.data()['phoneNumber'],
        gender: snapshot.data()['gender'],
        isTrainer: snapshot.data()['isTrainer'],
        age: snapshot.data()['age'],
        level: snapshot.data()['level'],
        name: snapshot.data()['name']
    );
  }


  Stream <PersonData> get personData{
    return personsCollection.doc(uid).snapshots().map(_personDataFromSnapshot);
  }




}
