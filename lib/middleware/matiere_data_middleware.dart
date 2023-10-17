import 'package:quiz_prokit/managers/matiere_manager.dart';
import 'package:quiz_prokit/model/matiere.dart';
import 'package:quiz_prokit/services/api/matiere_service.dart';
import '../services/connection_service.dart';

class MatiereData {
  MatiereManager matiereManager = MatiereManager();
  MatiereApiService matiereApiService = MatiereApiService();

  Future<List<Matiere>?> getData() async {
    try {
      if (await ConnectionService.isConnected()) {
        var data = await matiereApiService.getData();
        if (data != null) {
          updateMatiere(data);
          return data;
        }
        return await matiereManager.getData();
      } else {
        return await matiereManager.getData();
      }
    } catch (e) {
      return await matiereManager.getData();
    }
  }

  Future<void> updateMatiere(List<Matiere>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await matiereManager.updateData(element);
      });
    }
  }
}
