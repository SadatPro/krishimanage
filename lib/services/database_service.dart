import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/land_model.dart';
import '../models/crop_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'krishimanage.db');
    return await openDatabase(
      path,
      version: 2, // Increment version for group management
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table with group management
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL,
        userType TEXT NOT NULL,
        address TEXT NOT NULL,
        organization TEXT,
        designation TEXT,
        adminCode TEXT,
        groupName TEXT,
        managedGroups TEXT,
        maxFarmers INTEGER,
        createdAt TEXT NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    // Lands table
    await db.execute('''
      CREATE TABLE lands (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        area REAL NOT NULL,
        location TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        soilType TEXT NOT NULL,
        status TEXT NOT NULL,
        currentCrop TEXT,
        createdAt TEXT NOT NULL,
        lastUpdated TEXT,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');

    // Crops table
    await db.execute('''
      CREATE TABLE crops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        landId INTEGER NOT NULL,
        name TEXT NOT NULL,
        variety TEXT NOT NULL,
        plantingDate TEXT NOT NULL,
        expectedHarvestDate TEXT,
        actualHarvestDate TEXT,
        plantedArea REAL NOT NULL,
        expectedYield REAL,
        actualYield REAL,
        status TEXT NOT NULL,
        progress REAL NOT NULL,
        notes TEXT,
        createdAt TEXT NOT NULL,
        lastUpdated TEXT,
        FOREIGN KEY (landId) REFERENCES lands (id)
      )
    ''');

    // Soil data table
    await db.execute('''
      CREATE TABLE soil_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        landId INTEGER NOT NULL,
        ph REAL NOT NULL,
        nitrogen REAL NOT NULL,
        phosphorus REAL NOT NULL,
        potassium REAL NOT NULL,
        organicMatter REAL NOT NULL,
        moisture REAL NOT NULL,
        testDate TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (landId) REFERENCES lands (id)
      )
    ''');

    // Water data table
    await db.execute('''
      CREATE TABLE water_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        landId INTEGER NOT NULL,
        waterSource TEXT NOT NULL,
        irrigationType TEXT NOT NULL,
        waterQuality TEXT NOT NULL,
        ph REAL NOT NULL,
        salinity REAL NOT NULL,
        testDate TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (landId) REFERENCES lands (id)
      )
    ''');

    // Financial records table
    await db.execute('''
      CREATE TABLE financial_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        cropId INTEGER,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id),
        FOREIGN KEY (cropId) REFERENCES crops (id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add group management columns to users table
      await db.execute('ALTER TABLE users ADD COLUMN groupName TEXT');
      await db.execute('ALTER TABLE users ADD COLUMN managedGroups TEXT');
      await db.execute('ALTER TABLE users ADD COLUMN maxFarmers INTEGER');
    }
  }

  // User operations
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Group management operations
  Future<List<User>> getUsersByGroup(String groupName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'groupName = ? AND userType = ?',
      whereArgs: [groupName, 'farmer'],
    );
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<List<User>> getSupervisorsByManagedGroups(List<String> groups) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'userType = ?',
      whereArgs: ['supervisor'],
    );

    List<User> supervisors = [];
    for (var map in maps) {
      User supervisor = User.fromMap(map);
      if (supervisor.managedGroups != null) {
        List<String> managedGroups = supervisor.managedGroups!.split(',');
        for (String group in groups) {
          if (managedGroups.contains(group)) {
            supervisors.add(supervisor);
            break;
          }
        }
      }
    }
    return supervisors;
  }

  Future<List<String>> getAvailableGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['managedGroups'],
      where: 'userType = ? AND managedGroups IS NOT NULL',
      whereArgs: ['supervisor'],
    );

    Set<String> allGroups = {};
    for (var map in maps) {
      if (map['managedGroups'] != null) {
        List<String> groups = map['managedGroups'].split(',');
        allGroups.addAll(groups);
      }
    }
    return allGroups.toList()..sort();
  }

  Future<int> getFarmerCountInGroup(String groupName) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM users WHERE groupName = ? AND userType = ?',
      [groupName, 'farmer'],
    );
    return result.first['count'] as int;
  }

  Future<bool> isGroupAvailable(String groupName) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM users WHERE managedGroups LIKE ? AND userType = ?',
      ['%$groupName%', 'supervisor'],
    );
    return result.first['count'] as int > 0;
  }

  // Land operations
  Future<int> insertLand(Land land) async {
    final db = await database;
    return await db.insert('lands', land.toMap());
  }

  Future<List<Land>> getLandsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lands',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) => Land.fromMap(maps[i]));
  }

  Future<Land?> getLandById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lands',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Land.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateLand(Land land) async {
    final db = await database;
    return await db.update(
      'lands',
      land.toMap(),
      where: 'id = ?',
      whereArgs: [land.id],
    );
  }

  // Crop operations
  Future<int> insertCrop(Crop crop) async {
    final db = await database;
    return await db.insert('crops', crop.toMap());
  }

  Future<List<Crop>> getCropsByLandId(int landId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'crops',
      where: 'landId = ?',
      whereArgs: [landId],
    );
    return List.generate(maps.length, (i) => Crop.fromMap(maps[i]));
  }

  Future<List<Crop>> getActiveCropsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT c.* FROM crops c
      INNER JOIN lands l ON c.landId = l.id
      WHERE l.userId = ? AND c.status IN ('planted', 'growing', 'ready')
    ''',
      [userId],
    );
    return List.generate(maps.length, (i) => Crop.fromMap(maps[i]));
  }

  Future<int> updateCrop(Crop crop) async {
    final db = await database;
    return await db.update(
      'crops',
      crop.toMap(),
      where: 'id = ?',
      whereArgs: [crop.id],
    );
  }

  // Dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats(int userId) async {
    final db = await database;

    // Get user's lands
    final lands = await getLandsByUserId(userId);
    final totalLands = lands.length;
    final activeLands = lands.where((land) => land.status == 'active').length;

    // Get user's crops
    final crops = await getActiveCropsByUserId(userId);
    final totalCrops = crops.length;
    final readyForHarvest = crops
        .where((crop) => crop.isReadyForHarvest)
        .length;

    // Calculate total area
    final totalArea = lands.fold<double>(0, (sum, land) => sum + land.area);

    return {
      'totalLands': totalLands,
      'activeLands': activeLands,
      'totalCrops': totalCrops,
      'readyForHarvest': readyForHarvest,
      'totalArea': totalArea,
    };
  }
}
