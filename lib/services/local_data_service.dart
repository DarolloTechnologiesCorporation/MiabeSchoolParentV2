import 'package:path/path.dart';
import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

class LocalData<T> {
  Future<Database> initData() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      var def = TableHelper.getTableDefinition<T>();
      await db.execute(def);
    });
    return database;
  }

  Future<void> insertData(T data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          TableHelper.getInsertDefinition<T>(), TableHelper.toSQLData<T>());
    });
    database.close();
  }

  Future<int> updateData(T data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        TableHelper.getUpdateDefinition(), TableHelper.toSQLData<T>());
    database.close();
    return count;
  }

  Future<void> deleteData(Object id) async {
    var database = await initData();
    await database.rawDelete(TableHelper.getDeleteDefinition(), [id]);
    database.close();
  }

  Future<List<Object>> getData() async {
    var database = await initData();
    List<Map> list = await database.rawQuery('SELECT * FROM ${T.runtimeType}');
    database.close();
    return TableHelper.fromSQL<T>(list);
  }
}
