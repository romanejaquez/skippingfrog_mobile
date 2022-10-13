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
}