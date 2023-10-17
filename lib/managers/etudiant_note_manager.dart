import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/etudiant_note.dart';

class EtudiantNoteManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(EtudiantNote data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          EtudiantNote.getInsertDefinition(), EtudiantNote.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(EtudiantNote data) async {
    var database = await initData();
    int? nbr = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM EtudiantNote where Id = '${data.Id}' "));
    int count = 0;
    if (nbr != null) {
      if (nbr > 0) {
        count = await database.rawUpdate(EtudiantNote.getUpdateDefinition(),
            EtudiantNote.toUpdateSQLData(data));
      } else {
        await insertData(data);
      }
    }

    database.close();
    return count;
  }

  Future<void> deleteData(EtudiantNote etudiantNote) async {
    var database = await initData();
    await database.rawDelete(
        EtudiantNote.getDeleteDefinition(), [etudiantNote.Id.toString()]);
    database.close();
  }

  Future<List<EtudiantNote>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(EtudiantNote.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => EtudiantNote.fromSQL(list[i]));
  }

  Future<EtudiantNote?> getOndeEtudiantData(
      String etudiantId, String periodeId) async {
    var database = await initData();
    List<Map> maps = await database.query("EtudiantNote",
        columns: [
          "Matieres",
          "Notes",
          "TypeCompositions",
          "PeriodId",
          "EtudiantId"
        ],
        where: 'EtudiantId = ? and PeriodeId = ? ',
        whereArgs: [etudiantId, periodeId]);

    EtudiantNote? etudiantNote;
    database.close();
    if (maps.length > 0) {
      return EtudiantNote.fromSQL(maps.first);
    }

    return etudiantNote;
  }
}
