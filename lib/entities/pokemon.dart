class Pokemon {
  final int id;
  final String name;
  final int number;
  final double weight;
  final double height;

  Pokemon(
      {required this.id,
      required this.name,
      required this.number,
      required this.height,
      required this.weight});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
    );
  }
}