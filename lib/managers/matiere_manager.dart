import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/matiere.dart';

class MatiereManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(Matiere data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          Matiere.getInsertDefinition(), Matiere.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(Matiere data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        Matiere.getUpdateDefinition(), Matiere.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(Matiere matiere) async {
    var database = await initData();
    await database
        .rawDelete(Matiere.getDeleteDefinition(), [matiere.Id.toString()]);
    database.close();
  }

  Future<List<Matiere>?> getData() async {
    var database = await initData();
    List<Map> list = await database.rawQuery(Matiere.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => Matiere.fromJson(list[i]));
  }
}
