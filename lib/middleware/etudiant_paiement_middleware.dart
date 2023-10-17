import 'package:quiz_prokit/managers/etudiant_paiement_manager.dart';
import 'package:quiz_prokit/model/etudiant_paiement.dart';
import '../services/api/etudiant_paiement_service.dart';
import '../services/connection_service.dart';

class EtudiantPaiementData {
  EtudiantPaiementManager matiereManager = EtudiantPaiementManager();
  EtudiantPaiementService matiereApiService = EtudiantPaiementService();

  Future<List<EtudiantPaiement>?> getData() async {
    try {
      if (await ConnectionService.isConnected()) {
        var data = await matiereApiService.getData();
        if (data != null) {
          updateEtudiantPaiement(data);
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

  Future<void> updateEtudiantPaiement(List<EtudiantPaiement>? data) async {
    if (data != null) {
      await matiereManager.deleteAll();
      data.forEach((element) async {
        await matiereManager.updateData(element);
      });
    }
  }
}
