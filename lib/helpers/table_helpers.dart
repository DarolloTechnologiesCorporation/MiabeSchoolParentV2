import 'package:path/path.dart';
import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/model/etudiant_compta.dart';
import 'package:quiz_prokit/model/etudiant_note.dart';
import 'package:quiz_prokit/model/failed_paiement.dart';
import 'package:quiz_prokit/model/matiere.dart';
import 'package:quiz_prokit/model/notification.dart';
import 'package:quiz_prokit/model/periode.dart';
import 'package:quiz_prokit/model/type_composition.dart';
import 'package:sqflite/sqflite.dart';

import '../model/etudiant_paiement.dart';
import 'constant.dart';

class DatabaseHelper {
  static Future<Database> initData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, Constant.API_DB);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(Etudiant.getTableDefinition());
      await db.execute(EtudiantNote.getTableDefinition());
      await db.execute(Matiere.getTableDefinition());
      await db.execute(Periode.getTableDefinition());
      await db.execute(EtudiantCompta.getTableDefinition());
      await db.execute(TypeComposition.getTableDefinition());
      await db.execute(EtudiantPaiement.getTableDefinition());
      await db.execute(NotificationModel.getTableDefinition());
      await db.execute(FailedPaiementModel.getTableDefinition());
    });
    return database;
  }
}
