import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:veri_tabani_proje/member/member_model.dart';

class MemberDatabase {
  static Database? _database;

  final String _memberTable = "Member";

  final String _columnID = "id";
  final String _columnName = "name";
  final String _columnWeight = "weight";
  final String _columnHeight = "height";
  final String _columnPhone = "phone";
  final String _columnStatus = "status";

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "member.db");
    var memberDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return memberDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
      "Create table $_memberTable($_columnID integer primary key, $_columnName text, $_columnWeight text, $_columnHeight text, $_columnPhone text, $_columnStatus text)",
    );
  }

  //Crud Methods
  Future<List<Member>> getAllMember() async {
    Database db = await database;
    var result = await db.query(_memberTable);
    return List.generate(result.length, (i) {
      return Member.fromMap(result[i]);
    });
  }

  Future<int> insert(Member note) async {
    Database db = await database;
    var result = await db.insert(_memberTable, note.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    var result = await db.rawDelete("delete from $_memberTable where id=$id");
    return result;
  }

  Future<int> update(Member note) async {
    Database db = await database;
    var result = await db.update(_memberTable, note.toMap(), where: "id=?", whereArgs: [note.id]);
    return result;
  }

  Future<List<Member>> queryHeight(int threshold) async {
    Database db = await database;
    List<Member> members = [];
    var result =
        await db.rawQuery('SELECT * FROM $_memberTable WHERE $_columnHeight=?', [threshold]);
    for (var element in result) {
      members.add(Member.fromMap(element));
    }
    return members;
  }

  Future<List<Member>> queryWeight(int threshold) async {
    Database db = await database;
    List<Member> members = [];
    var result =
        await db.rawQuery('SELECT * FROM $_memberTable WHERE $_columnWeight=?', [threshold]);
    for (var element in result) {
      members.add(Member.fromMap(element));
    }
    return members;
  }

  Future<List<Member>> queryName(String name) async {
    Database db = await database;
    List<Member> members = [];
    var result = await db.rawQuery('SELECT * FROM $_memberTable WHERE $_columnName=?', [name]);
    for (var element in result) {
      members.add(Member.fromMap(element));
    }
    return members;
  }

  Future<List<Member>> queryStatus(String status) async {
    Database db = await database;
    List<Member> members = [];
    var result = await db.rawQuery('SELECT * FROM $_memberTable WHERE $_columnStatus=?', [status]);
    for (var element in result) {
      members.add(Member.fromMap(element));
    }
    return members;
  }
}
