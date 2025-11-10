import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/profile_model.dart';
import '../models/week_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mothercare.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE profile(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        lmpDate TEXT,
        dueDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE weeks(
        weekNumber INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        tips TEXT
      )
    ''');
  }

  // Profile CRUD
  Future<int> insertProfile(ProfileModel profile) async {
    final db = await instance.database;
    return await db.insert('profile', profile.toMap());
  }

  Future<ProfileModel?> getProfile() async {
    final db = await instance.database;
    final res = await db.query('profile');
    if (res.isNotEmpty) {
      return ProfileModel.fromMap(res.first);
    }
    return null;
  }

  // Week CRUD
  Future<void> insertWeeks(List<WeekModel> weeks) async {
    final db = await instance.database;
    for (var week in weeks) {
      await db.insert(
        'weeks',
        week.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<WeekModel>> getAllWeeks() async {
    final db = await instance.database;
    final res = await db.query('weeks');
    return res.map((e) => WeekModel.fromMap(e)).toList();
  }
}
