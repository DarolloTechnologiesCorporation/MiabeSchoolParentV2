import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notification.dart';

class NotificationModelManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(NotificationModel data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(NotificationModel.getInsertDefinition(),
          NotificationModel.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(NotificationModel data) async {
    var database = await initData();

    int? nbr = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM NotificationModel where Id = '${data.Id}' "));
    int count = 0;
    if (nbr != null) {
      if (nbr > 0) {
        count = await database.rawUpdate(
            NotificationModel.getUpdateDefinition(),
            NotificationModel.toUpdateSQLData(data));
      } else {
        await insertData(data);
      }
    }

    database.close();
    return count;
  }

  Future<void> deleteData(NotificationModel notification) async {
    var database = await initData();
    await database.rawDelete(
        NotificationModel.getDeleteDefinition(), [notification.Id.toString()]);
    database.close();
  }

  Future<List<NotificationModel>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(NotificationModel.getSelectDefinition());
    database.close();
    return List.generate(
        list.length, (i) => NotificationModel.fromSQL(list[i]));
  }
}
