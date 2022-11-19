class Training{
  final String uid;

  Training({required this.uid});
}

class TrainingData{

  final String date;
  final String day;
  final String hour;
  final int num_trainees;
  final int max_num_trainee = 7;
  final String u;
  final String trainer;
  List<dynamic> trainees;

  TrainingData({required this.date,required this.day,
    required this.hour, required this.num_trainees, required this.u,required this.trainer,
    required this.trainees});

}