import 'package:quiz_prokit/helpers/table_helpers.dart';
import 'package:sqflite/sqflite.dart';
import '../model/type_composition.dart';

class TypeCompositionManager {
  Future<Database> initData() async {
    return DatabaseHelper.initData();
  }

  Future<void> insertData(TypeComposition data) async {
    var database = await initData();
    await database.transaction((txn) async {
      await txn.rawInsert(TypeComposition.getInsertDefinition(),
          TypeComposition.toSQLData(data));
    });
    database.close();
  }

  Future<int> updateData(TypeComposition data) async {
    var database = await initData();
    int count = await database.rawUpdate(
        TypeComposition.getUpdateDefinition(), TypeComposition.toSQLData(data));
    database.close();
    return count;
  }

  Future<void> deleteData(TypeComposition typecomposition) async {
    var database = await initData();
    await database.rawDelete(
        TypeComposition.getDeleteDefinition(), [typecomposition.Id.toString()]);
    database.close();
  }

  Future<List<TypeComposition>?> getData() async {
    var database = await initData();
    List<Map> list =
        await database.rawQuery(TypeComposition.getSelectDefinition());
    database.close();
    return List.generate(list.length, (i) => TypeComposition.fromJson(list[i]));
  }
}
