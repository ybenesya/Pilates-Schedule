import 'package:flutter/material.dart';
import 'package:pilates_schedule/services/auth.dart';
import 'package:pilates_schedule/shared/constant.dart';
import 'package:pilates_schedule/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }



  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final List<String> genderList = ['female','male','genderless','gender'];
  final List<String> isTrainerList = ['trainer','trainee','are you trainer or trainee'];
  final List<String> levelList = ['beginner','medium','expert','your level in pilates training'];
  static String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp =new RegExp(patttern);

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String phoneNumber = '';
  String gender = '';
  bool isTrainer = true;
  String age = '';
  String level = '';

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Register to pilates schedule'),
        backgroundColor: Colors.pink[400],
        elevation: 0.0,
          actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.grey),
                ),
                onPressed: () => widget.toggleView(),
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
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) {
                    if (val != null && val.isEmpty){
                      return 'Enter a name';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Phone number'),
                  validator: (val) {
                    if (val != null &&!regExp.hasMatch(val)){
                      return 'Enter a valid phone number';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() => phoneNumber = val);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: genderList[3],
                  items: genderList.map((gen){
                    return DropdownMenuItem(
                      value: gen,
                      child: Text(gen),
                    );
                  }).toList(),
                  validator: (val) {
                    if (val == 'gender'){
                      return 'Choose a gender';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val) => setState(() => gender = val! ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: isTrainerList[2],
                  items: isTrainerList.map((t){
                    return DropdownMenuItem(
                      value: t,
                      child: Text(t),
                    );
                  }).toList(),
                  validator: (val) {
                    if (val == 'are you trainer or trainee'){
                      return 'Choose if you are trainer or trainee';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val) => setState(() {
                    if (val == 'trainer'){
                      isTrainer = true;
                    }
                    else{
                      isTrainer = false;

                    }
                  }),
                ),
                SizedBox(height: 20.0),
                Visibility(
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Age'),
                      validator: (val) {
                        if (val != null && val.isEmpty){
                          return 'Enter an age';
                        }else if(_isNumeric(val!) == false ){
                          return 'Enter a valid age';
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        setState(() => age = val);
                      },
                    ),
                  visible: !isTrainer,
                ),
                SizedBox(height: 20.0),
                Visibility(
                  child:DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: levelList[3],
                    items: levelList.map((l){
                      return DropdownMenuItem(
                        value: l,
                        child: Text(l),
                      );
                    }).toList(),
                    validator: (val) {
                      if (val == 'your level in pilates training'){
                        return 'Choose a level';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val) => setState(() => level = val! ),
                  ),
                  visible: !isTrainer,
                ),

                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) {
                    if (val != null && val.isEmpty){
                      return 'Enter an email';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) {
                    if (val != null && val.length < 6 ){
                      return 'Enter a password 6+ chars long';
                    }else{
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
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
                      if(isTrainer){
                        result = await _auth.registerWithEmailAndPasswordTrainer(email, password, name, phoneNumber, gender);
                      }else{
                        result = await _auth.registerWithEmailAndPasswordTrainee(email, password, name, phoneNumber, gender,age,level);
                      }
                      if (result == null){
                        setState(() {
                          error = 'please supply a valid details';
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}