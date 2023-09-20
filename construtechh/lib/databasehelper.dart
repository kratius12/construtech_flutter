import 'dart:io';

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Servicios {
  final int? id;
  final String nombre;
  final String apellido;
  final String fecha;
  final String tipoServ;
  final String telefono;
  final String municipio;
  final String direccion;
  Servicios(
      {this.id,
      required this.nombre,
      required this.apellido,
      required this.fecha,
      required this.tipoServ,
      required this.telefono,
      required this.municipio,
      required this.direccion});

  factory Servicios.fromMap(Map<String, dynamic> json) => Servicios(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        fecha: json["fecha"],
        tipoServ: json["tipoServ"],
        telefono: json['telefono'],
        municipio: json["municipio"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'fecha': fecha,
      'tipoServ': tipoServ,
      'telefono': telefono,
      "municipio": municipio,
      "direccion": direccion
    };
  }
}

class Usuarios {
  final int? id;
  final String nombre;
  final String apellido;
  final String email;
  final String password;
  const Usuarios(
      {this.id,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.password});
  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json["email"],
      password: json["password"]);
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nombre": nombre,
      "apellido": apellido,
      "email": email,
      "password": password
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'constru_tech.db');
    return await openDatabase(
      path,
      version: 5,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE servicios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellido TEXT,
        fecha TEXT,
        tipoServ TEXT,
        telefono TEXT,
        municipio TEXT,
        direccion TEXT
      )''');
    await db.execute('''
  CREATE TABLE usuarios(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT,
    apellido TEXT,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
  )
  ''');

  }

//Metodos para la gestión de base de datos en la tabla de usuarios
  Future<bool> login({required String email, required String password}) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  static Future<List<Usuarios>> getUsuarios() async {
    Database db = await instance.database;
    var usuarios = await db.query('usuarios');
    // ignore: non_constant_identifier_names
    List<Usuarios> UsuariosList = usuarios.isNotEmpty
        ? usuarios.map((c) => Usuarios.fromMap(c)).toList()
        : [];
    return UsuariosList;
  }

  Future<Object> register(Usuarios usuarios) async {
    Database db = await instance.database;
    return await db.insert('usuarios', usuarios.toMap());
  }

  static Future<int> updatePassword(
      {required String email, required String newPassword}) async {
    Database db = await instance.database;
    return await db.update(
      'usuarios',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  static Future<int> updateUser(
      {required nombre,
      required apellidos,
      required email,
      required newEmail}) async {
    Database db = await instance.database;
    return await db.update(
      'usuarios',
      {'nombre': nombre, 'apellido': apellidos, 'email': newEmail},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  //Metodos de gestion de base de datos con la tabla de servicios.
  static Future<List<Servicios>> getServices() async {
    Database db = await instance.database;
    var servicios = await db.query('servicios');
    // ignore: non_constant_identifier_names
    List<Servicios> ServicioList = servicios.isNotEmpty
        ? servicios.map((c) => Servicios.fromMap(c)).toList()
        : [];
    return ServicioList;
  }

  Future<int> add(Servicios servicios) async {
    Database db = await instance.database;
    return await db.insert('servicios', servicios.toMap());
  }

  static Future<int> remove({required id}) async {
    Database db = await instance.database;
    return await db.delete('servicios', where: 'id = ?', whereArgs: [id]);
  }

  Future update(
      {id,
      nombre,
      apellido,
      fecha,
      tipoServ,
      telefono,
      municipio,
      direccion}) async {
    final db = await database;
    int dbupdate = await db.rawUpdate(
        'UPDATE servicios SET email=? nombre = ?, apellido =?, fecha = ?, tipoServ = ?, telefono = ?, municipio = ?, direccion = ? WHERE id = ?',
        [
          nombre,
          apellido,
          fecha,
          tipoServ,
          telefono,
          municipio,
          direccion,
          id
        ]);
    return dbupdate;
  }
}
