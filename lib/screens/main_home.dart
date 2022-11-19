import 'package:flutter/material.dart';
import 'package:pilates_schedule/models/person.dart';
import 'package:pilates_schedule/screens/home.dart';
import 'package:pilates_schedule/screens/settings.dart';
import 'package:pilates_schedule/screens/training/trainings_schedual.dart';
import 'package:pilates_schedule/screens/training/add_training.dart';
import 'package:pilates_schedule/screens/training/delete_training.dart';
import 'package:pilates_schedule/screens/trainee/trainees.dart';
import 'package:pilates_schedule/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pilates_schedule/shared/loading.dart';

class MainHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp( home: MyMainHome(),);
  }
}

class MyMainHome extends StatefulWidget {

  @override
  State<MyMainHome> createState() => _MyMainHomeState();
}

class _MyMainHomeState extends State<MyMainHome> {
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  final _bottomNavigationBarItemsTrainer = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.pinkAccent),
        label: 'Home',),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month, color: Colors.pinkAccent),
      label: 'Schedual',),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.pinkAccent),
      label: 'Trainees',),
    BottomNavigationBarItem(
      icon: Icon(Icons.add, color: Colors.pinkAccent),
      label: 'Add',),
  ];

  final _bottomNavigationBarItemsTrainee = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.pinkAccent),
      label: 'Home',),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month, color: Colors.pinkAccent),
      label: 'Schedual',),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings, color: Colors.pinkAccent),
      label: 'Settings',),
  ];


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Person>(context);

    return StreamBuilder<PersonData>(
      stream:DatabaseServicePerson(uid: user.uid).personData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PersonData personData = snapshot.data!;
          if (personData.isTrainer){
            return Scaffold(
              body:
              PageView(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [Home(),DeleteTraining(),Trainees(),AddTraining()],),
              bottomNavigationBar:BottomNavigationBar(
                currentIndex: _currentIndex,
                items: _bottomNavigationBarItemsTrainer,
                type: BottomNavigationBarType.fixed,
                onTap: (index){
                  _pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
                },
              ),

            );
          }
          else{
            return Scaffold(
              body:
              PageView(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [Home(),TrainingSchedual(), Settings()],),
              bottomNavigationBar:BottomNavigationBar(
                currentIndex: _currentIndex,
                items: _bottomNavigationBarItemsTrainee,
                type: BottomNavigationBarType.fixed,
                onTap: (index){
                  _pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
                },
              ),

            );
          }

        } else {
          return Loading();
        }
      }
    );
  }
}

