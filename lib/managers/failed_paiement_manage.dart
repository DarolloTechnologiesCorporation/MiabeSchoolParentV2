import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:quiz_prokit/model/failed_paiement.dart';
import 'package:sqflite/sqflite.dart';

class FailedPaiementModelManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(FailedPaiementModel data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(FailedPaiementModel.getInsertDefinition(),
          FailedPaiementModel.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(FailedPaiementModel data) async {
    var database = await initData();
    int? nbr = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM FailedPaiementModel where Id = '${data.Id}' "));
    int count = 0;
    if (nbr != null) {
      if (nbr > 0) {
        count = await database.rawUpdate(
            FailedPaiementModel.getUpdateDefinition(),
            FailedPaiementModel.toUpdateSQLData(data));
      } else {
        await insertData(data);
      }
    }
    database.close();
    return count;
  }

  Future<void> deleteData(FailedPaiementModel failedPaiementModel) async {
    var database = await initData();
    await database.rawDelete(FailedPaiementModel.getDeleteDefinition(),
        [failedPaiementModel.Id.toString()]);
    database.close();
  }

  Future<List<FailedPaiementModel>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(FailedPaiementModel.getSelectDefinition());
    database.close();
    return List.generate(
        list.length, (i) => FailedPaiementModel.fromSQL(list[i]));
  }
}
