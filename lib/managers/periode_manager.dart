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
    int? nbr = Sqflite.firstIntValue(await database
        .rawQuery("SELECT COUNT(*) FROM Periode where Id = '${data.Id}' "));
    int count = 0;
    if (nbr != null) {
      if (nbr > 0) {
        count = await database.rawUpdate(
            Periode.getUpdateDefinition(), Periode.toUpdateSQLData(data));
      } else {
        await database.transaction((txn) async {
          await txn.rawInsert(
              Periode.getInsertDefinition(), Periode.toSQLData(data));
        });
      }
    }

    //  database.close();
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

  Future<List<Periode>?> getEcolePeriodeData(String etudiantId) async {
    var database = await initData();
    List<Map> maps = await database.query("Periode",
        columns: [
          "Libelle",
          "EtudiantId",
          "Datedebut",
          "AnneAcademique",
          "Datefin",
        ],
        where: 'EtudiantId = ?',
        whereArgs: [etudiantId]);

    List<Periode>? periode;
    database.close();
    if (maps.length > 0) {
      periode = List.generate(maps.length, (i) => Periode.fromSQL(maps[i]));
    }
    return periode;
  }
}
