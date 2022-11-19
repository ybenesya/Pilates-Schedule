import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:pilates_schedule/shared/loading.dart';
import 'package:pilates_schedule/shared/constant.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> level = ['beginner','medium','expert'];


  // form values
  String? _currentName;
  String? _currentAge;
  String? _currentLevel;
  String? _currentPhoneNumber;

  @override

  Widget build(BuildContext context) {

    final user = Provider.of<Person>(context);


    return StreamBuilder<PersonData>(
      stream: DatabaseServicePerson(uid:user.uid).personData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          PersonData personData = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.pink[50],
            appBar: AppBar(
              title: Text('Settings'),
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
              padding: EdgeInsets.symmetric(horizontal:50.0, vertical: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                  Text(
                  'Update your settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: personData.name ,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  initialValue: personData.age ,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter an age' : null,
                  onChanged: (val) => setState(() => _currentAge = val),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentLevel ?? personData.level,
                  items: level.map((l){
                    return DropdownMenuItem(
                      value: l,
                      child: Text('level: $l '),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentLevel = val! ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  initialValue: personData.phoneNumber ,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a phone nuber' : null,
                  onChanged: (val) => setState(() => _currentPhoneNumber = val),
                ),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[900],
                        ),
                        child: Text('Update',
                          style: TextStyle(color: Colors.white,),),
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            await DatabaseServicePerson(uid:user.uid).updatePersonData(
                                _currentName ?? personData.name,
                                _currentPhoneNumber ?? personData.phoneNumber,
                                personData.gender,
                                personData.isTrainer,
                                _currentAge ?? personData.age,
                                _currentLevel ?? personData.level);
                          }
                        }
                    ),

                  ]
                ),
              ),
            ),
          );
        }
        else{
          return Loading();
        }
      },

    );



  }
}
