import 'package:quiz_prokit/managers/etudiant_compta.dart';
import 'package:quiz_prokit/model/etudiant_compta.dart';
import 'package:quiz_prokit/services/api/etudiant_compta_service.dart';
import 'package:quiz_prokit/services/connection_service.dart';

class EtudiantComptaData {
  EtudiantComptaManager etudiantManager = EtudiantComptaManager();
  EtudiantComptaService etudiantApiService = EtudiantComptaService();

  Future<List<EtudiantCompta>?> getData() async {
    try {
      if (await ConnectionService.isConnected()) {
        var data = await etudiantApiService.getData();
        if (data != null) {
          updateEtudiantCompta(data);
          return data;
        }
        return await etudiantManager.getData();
      } else {
        return await etudiantManager.getData();
      }
    } catch (e) {
      return await etudiantManager.getData();
    }
  }

  Future<void> updateEtudiantCompta(List<EtudiantCompta>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await etudiantManager.updateData(element);
      });
    }
  }
}
