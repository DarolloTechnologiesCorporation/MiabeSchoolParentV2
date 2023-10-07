import 'package:quiz_prokit/managers/etudiant_manager.dart';
import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/services/api/etudiant_service.dart';
import '../services/connection_service.dart';

class EtudiantData {
  EtudiantManager etudiantManager = EtudiantManager();
  EtudiantApiService etudiantApiService = EtudiantApiService();

  Future<List<Etudiant>?> getData() async {
    if (await ConnectionService.isConnected()) {
      var data = await etudiantApiService.getData();
      updateEtudiant(data);
      return data;
    } else {
      return await etudiantManager.getData();
    }
  }

  Future<void> updateEtudiant(List<Etudiant>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await etudiantManager.updateData(element);
      });
    }
  }
}
