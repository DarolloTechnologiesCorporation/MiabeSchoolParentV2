import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/composition.dart';

class CompositionManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(Composition data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          Composition.getInsertDefinition(), Composition.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(Composition data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        Composition.getUpdateDefinition(), Composition.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(Composition composition) async {
    var database = await initData();
    await database.rawDelete(
        Composition.getDeleteDefinition(), [composition.Id.toString()]);
    database.close();
  }

  Future<List<Composition>?> getData() async {
    var database = await initData();
    List<Map> list = await database.rawQuery(Composition.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => Composition.fromJson(list[i]));
  }
}
