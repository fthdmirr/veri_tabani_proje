import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:veri_tabani_proje/trainers/trainer_model.dart';

class TrainerDatabase {
  static Database? _database;

  final String _trainerTable = "Trainer";

  final String _columnID = "id";
  final String _columnName = "name";
  final String _columnSalary = "salary";
  final String _columnYear = "year";
  final String _columnProfession = "profession";

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "Trainer.db");
    var trainerDb = await openDatabase(dbPath, version: 2, onCreate: createDb);
    return trainerDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
      "Create table $_trainerTable($_columnID integer primary key, $_columnName text, $_columnSalary text, $_columnYear text, $_columnProfession text)",
    );
  }

  //Crud Methods
  Future<List<Trainer>> getAllTrainer() async {
    Database db = await database;
    var result = await db.query(_trainerTable);
    return List.generate(result.length, (i) {
      return Trainer.fromMap(result[i]);
    });
  }

  Future<int> insert(Trainer trainer) async {
    Database db = await database;
    var result = await db.insert(_trainerTable, trainer.toMap());
    return result;
  }

  Future<List<Trainer>> queryID(int id) async {
    Database db = await database;
    List<Trainer> trainers = [];
    var result = await db.rawQuery('SELECT * FROM $_trainerTable WHERE $_columnID=?', [id]);
    for (var element in result) {
      trainers.add(Trainer.fromMap(element));
    }
    return trainers;
  }

  Future<List<Trainer>> quetySalary(int salary) async {
    Database db = await database;
    List<Trainer> trainers = [];
    var result = await db.rawQuery('SELECT * FROM $_trainerTable WHERE $_columnSalary=?', [salary]);
    for (var element in result) {
      trainers.add(Trainer.fromMap(element));
    }
    return trainers;
  }
}
