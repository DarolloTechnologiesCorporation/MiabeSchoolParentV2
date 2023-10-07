import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/periode.dart';

class PeriodeManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(Periode data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          Periode.getInsertDefinition(), Periode.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(Periode data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        Periode.getUpdateDefinition(), Periode.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(Periode periode) async {
    var database = await initData();
    await database
        .rawDelete(Periode.getDeleteDefinition(), [periode.Id.toString()]);
    database.close();
  }

  Future<List<Periode>?> getData() async {
    var database = await initData();
    List<Map> list = await database.rawQuery(Periode.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => Periode.fromJson(list[i]));
  }
}
