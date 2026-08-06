class TeamModel {
  final String id;
  final String name;
  final String logo;

  TeamModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory TeamModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return TeamModel(
      id: id,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logo,
    };
  }
}