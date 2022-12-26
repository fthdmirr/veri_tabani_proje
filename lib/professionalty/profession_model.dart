class Profession {
  final int id;
  final String name;

  Profession(
    this.id,
    this.name,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    
    return map;
  }

  factory Profession.fromMap(Map<String, dynamic> map) {
    return Profession(map['id'], map['name']);
  }
}
