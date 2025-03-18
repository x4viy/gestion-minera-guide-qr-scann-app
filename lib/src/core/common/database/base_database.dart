// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// abstract class BaseDatabase {
//   final String databaseName;
//   final int databaseVersion;
//   Database? _database;

//   BaseDatabase(this.databaseName, this.databaseVersion);

//   Future<Database> get database async {
//     _database ??= await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     return openDatabase(
//       join(await getDatabasesPath(), databaseName),
//       version: databaseVersion,
//       onCreate: onCreate,
//     );
//   }

//   Future<void> onCreate(Database db, int version);
// }
