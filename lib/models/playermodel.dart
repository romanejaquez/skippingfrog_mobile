class PlayerModel {
  final String id;
  final String name;
  final int score;
  final int timeInSeconds;

  PlayerModel({
    required this.id,
    required this.name,
    required this.score,
    required this.timeInSeconds
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json, String playerId) {
    return PlayerModel(
      id: playerId,
      name: json['name'], 
      score: json['score'],
      timeInSeconds: json['timeInSeconds']);
  }
}