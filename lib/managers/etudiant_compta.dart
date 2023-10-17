import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:quiz_prokit/model/etudiant_compta.dart';
import 'package:sqflite/sqflite.dart';

class EtudiantComptaManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(EtudiantCompta data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          EtudiantCompta.getInsertDefinition(), EtudiantCompta.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(EtudiantCompta data) async {
    var database = await initData();
    int? nbr = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM EtudiantCompta where EtudiantId = '${data.EtudiantId}' "));
    int count = 0;
    if (nbr != null) {
      if (nbr > 0) {
        count = await database.rawUpdate(EtudiantCompta.getUpdateDefinition(),
            EtudiantCompta.toUpdateSQLData(data));
      } else {
        await insertData(data);
      }
    }

    database.close();
    return count;
  }

  Future<void> deleteData(EtudiantCompta etudiant) async {
    var database = await initData();
    await database.rawDelete(
        EtudiantCompta.getDeleteDefinition(), [etudiant.EtudiantId.toString()]);
    database.close();
  }

  Future<List<EtudiantCompta>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(EtudiantCompta.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => EtudiantCompta.fromSQL(list[i]));
  }
}
