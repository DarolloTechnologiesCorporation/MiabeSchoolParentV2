import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/etudiant_paiement.dart';

class EtudiantPaiementManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(EtudiantPaiement data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(EtudiantPaiement.getInsertDefinition(),
          EtudiantPaiement.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(EtudiantPaiement data) async {
    var database = await initData();
    int count = 0;

    count = await database.rawUpdate(EtudiantPaiement.getUpdateDefinition(),
        EtudiantPaiement.toUpdateSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteAll() async {
    var database = await initData();
    await database.rawDelete("DELETE FROM EtudiantPaiement where 1 = 1");
  }

  Future<void> deleteData(EtudiantPaiement etudiantPaiement) async {
    var database = await initData();
    await database.rawDelete(EtudiantPaiement.getDeleteDefinition(),
        [etudiantPaiement.EtudiantId.toString()]);
    database.close();
  }

  Future<List<EtudiantPaiement>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(EtudiantPaiement.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => EtudiantPaiement.fromSQL(list[i]));
  }
}
