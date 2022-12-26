class Trainer {
  int? id;
  final String name;
  final String salary;
  final String year;
  final String profession;

  Trainer(this.name, this.salary, this.year, this.profession);

  Trainer.withId(this.id, this.name, this.salary, this.year, this.profession);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["salary"] = salary;
    map["year"] = year;
    map['profession'] = profession;
    return map;
  }

  factory Trainer.fromMap(Map<String, dynamic> map) {
    return Trainer.withId(map['id'], map['name'], map['salary'], map['year'], map['profession']);
  }
}
