import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:pilates_schedule/shared/constant.dart';
import 'package:pilates_schedule/shared/loading.dart';
import 'package:provider/provider.dart';

class AddTraining extends StatefulWidget {
  @override
  State<AddTraining> createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  final AuthService _auth = AuthService();
  @override

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  final List<String> dayList = ['Sunday','Monday','Tuesday','Wednesday','Thursday',
    'Friday','Saturday','Choose day'];

  static String patttern = r'(^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$)';
  RegExp regExp =new RegExp(patttern);

  String date = '';
  String hour = '';
  String day = '';
  String error = '';
  String comment= '';


  Widget build(BuildContext context) {

    final person = Provider.of<Person>(context);
    String name ="";

    return StreamBuilder<PersonData>(
      stream: DatabaseServicePerson(uid: person.uid).personData,
      builder: (context, snapshot){
        if (snapshot.hasData){
          name = snapshot.data!.name;
        }
        else{
          name = 'Manager';
        }
        return loading ? Loading(): Scaffold(
          backgroundColor: Colors.pink[50],
          appBar: AppBar(
            title: Text('Add Training'),
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
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Date'),
                      validator: (val) {
                        if (val != null && val.isEmpty){
                          return 'Enter a date';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        setState(() => date = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: dayList[7],
                      items: dayList.map((d){
                        return DropdownMenuItem(
                          value: d,
                          child: Text(d),
                        );
                      }).toList(),
                      validator: (val) {
                        if (val == 'Choose day'){
                          return 'Choose day of the week';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (val) => setState(() => day = val! ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Hour'),
                      validator: (val) {
                        if (val != null &&!regExp.hasMatch(val)){
                          return 'Enter a valid hour HH:MM';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        setState(() => hour = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Colors.pink[900],
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white,),
                      ),
                      onPressed: () async{
                        if( _formKey.currentState!.validate()){
                          setState(() => loading = true);
                          dynamic result;
                          result = await _auth.addTraining(date, day, hour,name);
                          setState(() => loading = false);
                          comment = 'The training was successfully added!';
                          if (result == null){
                            setState(() {
                              error = 'Please supply a valid details';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize:14.0 ),
                    ),
                    Text(
                      comment,
                      style: TextStyle(color: Colors.black, fontSize:20.0),
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
              ),
            ),

          ),
        );
      },
    );



  }
}
