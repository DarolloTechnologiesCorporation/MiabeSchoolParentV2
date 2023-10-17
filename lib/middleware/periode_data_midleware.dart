import 'package:quiz_prokit/managers/periode_manager.dart';
import 'package:quiz_prokit/model/periode.dart';
import 'package:quiz_prokit/services/api/periode_service.dart';
import '../services/connection_service.dart';

class PeriodeData {
  PeriodeManager periodeManager = PeriodeManager();
  PeriodeApiService periodeApiService = PeriodeApiService();

  Future<List<Periode>?> getData(String etudiantId) async {
    try {
      if (await ConnectionService.isConnected()) {
        var data = await periodeApiService.getEcolePeriodeData(etudiantId);
        if (data != null) {
          updatePeriode(data);
          return data;
        }
        return await periodeManager.getEcolePeriodeData(etudiantId);
      } else {
        return await periodeManager.getEcolePeriodeData(etudiantId);
      }
    } catch (e) {
      return await periodeManager.getEcolePeriodeData(etudiantId);
    }
  }

  Future<void> updatePeriode(List<Periode>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await periodeManager.updateData(element);
      });
    }
  }
}
