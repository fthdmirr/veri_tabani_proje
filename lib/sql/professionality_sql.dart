import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:veri_tabani_proje/professionalty/profession_model.dart';

class ProfessionDatabase {
  static Database? _database;

  final String _professionTable = "Profession";

  final String _columnID = "id";
  final String _columnTitle = "title";

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "Profession.db");
    var professionDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return professionDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $_professionTable($_columnID integer primary key, $_columnTitle text)");
  }

  //Crud Methods
  Future<List<Profession>> getAllProfession() async {
    Database db = await database;
    var result = await db.query(_professionTable);
    return List.generate(result.length, (i) {
      return Profession.fromMap(result[i]);
    });
  }

  Future<int> insert(Profession note) async {
    Database db = await database;
    var result = await db.insert(_professionTable, note.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    var result = await db.rawDelete("delete from $_professionTable where id=$id");
    return result;
  }

  Future<int> update(Profession note) async {
    Database db = await database;
    var result = await db.update(_professionTable, note.toMap(), where: "id=?", whereArgs: [note.id]);
    return result;
  }
}
