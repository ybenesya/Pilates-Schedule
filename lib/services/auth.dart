import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/models/training.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:uuid/uuid.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create Person object based on FirebaseUser
  Person? _personFromFirebaseUser(User user){
    return user != null ? Person(uid: user.uid) : null;
  }

  // create Training object based on FirebaseUser
  Training? _trainingFromFirebaseUser(String uid){
    if (uid != null){
      return Training(uid: uid);
    }
    else{
      return null;
    }
  }



  // auth change user stream
  Stream<Person?> get user{
    return _auth.authStateChanges().map(_personFromFirebaseUser);
  }

  // sign in trainer/ trainee
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _personFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register trainer
  Future registerWithEmailAndPasswordTrainer(String email, String password,
      String name,String phoneNumber, String gender) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      await DatabaseServicePerson(uid: user.uid).updatePersonData(
          name, phoneNumber, gender, true, '', '');
      return _personFromFirebaseUser(user);
    } catch(e){
      return null;
    }
  }

  // register trainee
  Future registerWithEmailAndPasswordTrainee(String email, String password,
      String name,String phoneNumber, String gender, String age, String level) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      await DatabaseServicePerson(uid:user.uid).updatePersonData(name, phoneNumber, gender,false,age, level);
      return _personFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


// sigh out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future addTraining(String date, String day, String hour, String trainer_name) async{
    try {
      var uuid = DateTime.now().millisecondsSinceEpoch;
      String uid = uuid.toString();
      //create a new document for the user with the uid
      await DatabaseServiceTraining(uid: uid).updateTrainingData(
          date, day, hour,0,uid, trainer_name);
      return _trainingFromFirebaseUser(uid);
    } catch(e){
      return null;
    }
  }


}