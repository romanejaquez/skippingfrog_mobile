class ScoreConfig {
  final int bugs;
  final int score;
  final Duration time;
  final String timeAsString;

  ScoreConfig({
    required this.bugs,
    required this.score,
    required this.time,
    required this.timeAsString
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'timeAsString': timeAsString,
      'time': time.inSeconds,
      'bugs': bugs
    };
  }

  factory ScoreConfig.fromJson(Map<String, dynamic> json) {
    return ScoreConfig(
      bugs: json['bugs'], 
      score: json['score'],
      time: Duration(seconds: json['time']), 
      timeAsString: json['timeAsString']
    );
  }
}