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
    int count = await database.rawUpdate(
        EtudiantNote.getUpdateDefinition(), EtudiantNote.toSQLData(data));
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
    return List.generate(list.length, (i) => EtudiantNote.fromJson(list[i]));
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
      return EtudiantNote.fromJson(maps.first);
    }

    return etudiantNote;
  }
}
