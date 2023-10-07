import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/etudiant.dart';

class EtudiantManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(Etudiant data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          Etudiant.getInsertDefinition(), Etudiant.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(Etudiant data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        Etudiant.getUpdateDefinition(), Etudiant.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(Etudiant etudiant) async {
    var database = await initData();
    await database
        .rawDelete(Etudiant.getDeleteDefinition(), [etudiant.Id.toString()]);
    database.close();
  }

  Future<List<Etudiant>?> getData() async {
    var database = await initData();
    List<Map> list = await database.rawQuery(Etudiant.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => Etudiant.fromJson(list[i]));
  }
}
