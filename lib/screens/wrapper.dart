import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/screens/authenticate/authenticate.dart';
import 'package:pilates_schedule/shared/loading.dart';
import 'package:pilates_schedule/screens/home.dart';
import 'package:pilates_schedule/screens/main_home.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final person = Provider.of<Person>(context);

    //return either Home or either authentication of trainee
    if (person == null){
      return Authenticate();
    }else{
      return MainHome();
    }
  }
}
