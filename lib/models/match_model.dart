class MatchModel {
  final String id;
  final String teamA;
  final String teamB;
  final String teamAScore;
  final String teamBScore;
  final String overs;
  final String status;
  final String tournament;
  final String ground;
  final String youtubeUrl;

  MatchModel({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.teamAScore,
    required this.teamBScore,
    required this.overs,
    required this.status,
    required this.tournament,
    required this.ground,
    required this.youtubeUrl,
  });

  factory MatchModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return MatchModel(
      id: id,
      teamA: map['teamA'] ?? '',
      teamB: map['teamB'] ?? '',
      teamAScore: map['teamAScore'] ?? '',
      teamBScore: map['teamBScore'] ?? '',
      overs: map['overs'] ?? '',
      status: map['status'] ?? 'Upcoming',
      tournament: map['tournament'] ?? '',
      ground: map['ground'] ?? '',
      youtubeUrl: map['youtubeUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamA': teamA,
      'teamB': teamB,
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
      'overs': overs,
      'status': status,
      'tournament': tournament,
      'ground': ground,
      'youtubeUrl': youtubeUrl,
    };
  }
}