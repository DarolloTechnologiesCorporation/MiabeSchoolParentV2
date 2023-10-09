import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notification.dart';

class NotificationManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(Notification data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(
          Notification.getInsertDefinition(), Notification.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(Notification data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        Notification.getUpdateDefinition(), Notification.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(Notification notification) async {
    var database = await initData();
    await database.rawDelete(
        Notification.getDeleteDefinition(), [notification.Id.toString()]);
    database.close();
  }

  Future<List<Notification>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(Notification.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => Notification.fromJson(list[i]));
  }
}
