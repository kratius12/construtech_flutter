import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
List TodosLosLibros = [];

class LocalDatabase {
  Future get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Local.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE libro(id INTEGER PRIMARY KEY,
        Titulo TEXT NOT NULL,
        Descripcion TEXT NOT NULL,
        FechaP TEXT NOT NULL,
        Precio TEXT NOT NULL
        )
        ''');
  }

  Future addDataLocal({titulo, descripcion, fecha, precio}) async {
    final db = await database;
    await db.insert("libro", {
      "Titulo": titulo,
      "Descripcion": descripcion,
      "FechaP": fecha,
      "Precio": precio
    });
    print('libro: ${titulo} Guardado con exito!');
    return 'Agregado!';
  }

  Future readallbooks() async {
    final db = await database;
    final allbooks = await db!.query('libro');
    TodosLosLibros = allbooks;
    print(TodosLosLibros);
    return "Mostrando libros...";
  }

  Future updatebook({id, titulo, descripcion, fecha, precio}) async {
    final db = await database;
    int dbupdate = await db.rawUpdate(
        'UPDATE libro SET Titulo = ?, Descripcion =?, FechaP = ?, Precio = ? WHERE id = ?',
        [titulo, descripcion, fecha, precio, id]);
    return dbupdate;
  }

  Future deletebook({id}) async {
    final db = await database;
    await db!.delete("libro", where: 'id=?', whereArgs: [id]);
    print("Eliminado libro  ${id}");
    return "Eliminado con exito!";
  }
}
