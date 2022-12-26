class Member {
  int? id;
  final String name;
  final String weight;
  final String height;
  final String phone;
  final String status;

  Member(this.name, this.weight, this.height, this.phone, this.status);
  Member.withID(this.id,this.name, this.weight, this.height, this.phone, this.status);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["weight"] = weight;
    map["height"] = height;
    map["phone"] = phone;
    map["status"] = status;

    return map;
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member.withID(
      map['id'],
      map['name'],
      map['weight'],
      map['height'],
      map['phone'],
      map['status'],
    );
  }
}
