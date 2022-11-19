import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/services/auth.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<Person>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
