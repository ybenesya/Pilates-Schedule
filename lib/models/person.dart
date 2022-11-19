class Person{
  final String uid;

  Person({required this.uid});
}

class PersonData{
  final String uid;
  final String phoneNumber;
  final String gender;
  final bool isTrainer;
  final String age;
  final String level;
  final String name;

  PersonData({ required this.uid, required this.phoneNumber,required this.gender,
    required this.isTrainer, required this.age, required this.level, required this.name });
}