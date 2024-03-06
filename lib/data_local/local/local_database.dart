import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/data_local/models/category_model.dart';
import '../models/category/category_model.dart';
import '../models/category/category_model_constants.dart';
import '../models/task/tack_model.dart';
import '../models/task/task_model_constants.dart';

class LocalDatabase {
  //Step 1
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  //-----
  //Step 2
  Database? _database;

  //Step 3
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("todo.db");
      return _database!;
    }
  }

  //Step 4
  Future<Database> _init(String databaseName) async {
    //......Android/data
    String internalPath = await getDatabasesPath();
    //......Android/data/todo.db
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //--------------------------READY TO USE------------------------

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''CREATE TABLE ${TaskModelConstants.tableName} (
      ${TaskModelConstants.id} $idType,
      ${TaskModelConstants.title} $textType,
      ${TaskModelConstants.description} $textType,
      ${TaskModelConstants.deadline} $textType,
      ${TaskModelConstants.status} $textType,
      ${TaskModelConstants.category} $textType,
      ${TaskModelConstants.priority} $intType
    )''');
    await db.execute('''CREATE TABLE ${CategoryModelConstants.tableName} (
      ${CategoryModelConstants.id} $idType,
      ${CategoryModelConstants.name} $textType,
      ${CategoryModelConstants.iconPath} $textType,
      ${CategoryModelConstants.color} $textType
    )''');


  }

  static Future<TaskModel> insertTask(TaskModel taskModel) async {
    debugPrint("INITIAL ID:${taskModel.id}");
    final db = await databaseInstance.database;
    int savedTaskID =
        await db.insert(TaskModelConstants.tableName, taskModel.toJson());
    debugPrint("SAVED ID:$savedTaskID");
    return taskModel.copyWith(id: savedTaskID);
  }


  //============CATEGORY TABLE ===========//
  static Future<CategoryModels> insertCategory(CategoryModels categoryModels) async {
    debugPrint("INITIAL ID:${categoryModels.id}");
    final db = await databaseInstance.database;
    int savedCategoryID = await db.insert(
        CategoryModelConstants.tableName, categoryModels.toJson());
    debugPrint("SAVED ID:$savedCategoryID");
    return categoryModels.copyWith(id: savedCategoryID);
  }

  //==============================

  static Future<List<TaskModel>> getAllTasks() async {
    final db = await databaseInstance.database;
    String orderBy = "${TaskModelConstants.id} DESC"; //"_id DESC"
    List json = await db.query(TaskModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

  //============CATEGORY LIST ===========//
  static Future<List<CategoryModels>> getAllCategory() async {
    final db = await databaseInstance.database;
    String orderBy = "${CategoryModelConstants.id} DESC"; //"_id DESC"
    List json = await db.query(CategoryModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => CategoryModels.fromJson(e)).toList();
  }


  // delete task // == //
  static Future<int> deleteTask(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      TaskModelConstants.tableName,
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }

  // update task //
  static Future<int> updateTask(TaskModel taskModel, int id) async {
    final db = await databaseInstance.database;
    int updateTaskTd = await db.update(
      TaskModelConstants.tableName,
      taskModel.toJson(),
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [id],
    );
    return updateTaskTd;
  }

  static updateTaskStatus({
    required String newStatus,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updateTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.status: newStatus},
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [taskId],
    );
    return updateTaskId;
  }

  static updateTaskTitle({
    required String newTitle,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updateTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.title: newTitle},
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [taskId],
    );
    return updateTaskId;
  }

  static updateTaskDescription({
    required String newDescription,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updateTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.title: newDescription},
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [taskId],
    );
    return updateTaskId;
  }

  static Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final db = await databaseInstance.database;
    String orderBy = "${TaskModelConstants.deadline} ASC";
    List json = await db.query(
      TaskModelConstants.tableName,
      where: "${TaskModelConstants.deadline} >= ? AND ${TaskModelConstants.deadline} < ?",
      whereArgs: [
        "${date.year}-${date.month}-${date.day} 00:00:00",
        "${date.year}-${date.month}-${date.day + 1} 00:00:00"
      ],
      orderBy: orderBy,
    );
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }


  static updateTaskCategory({
    required String newCategory,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updateTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.category: newCategory},
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [taskId],
    );
    return updateTaskId;
  }

  static updateTaskPriority({
    required String newPriority,
    required int taskId,
  }) async {
    final db = await databaseInstance.database;
    int updateTaskId = await db.update(
      TaskModelConstants.tableName,
      {TaskModelConstants.priority: newPriority},
      where: "${TaskModelConstants.id} = ?",
      whereArgs: [taskId],
    );
    return updateTaskId;
  }


  static Future<List<TaskModel>> searchTasks(String query) async {
    final db = await databaseInstance.database;
    var json = await db.query(
      TaskModelConstants.tableName,
      where: "${TaskModelConstants.title} LIKE ?",
      whereArgs: ["$query%"],
    );
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }
}
