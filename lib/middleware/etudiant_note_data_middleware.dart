import 'package:quiz_prokit/managers/etudiant_note_manager.dart';

import 'package:quiz_prokit/model/etudiant_note.dart';
import 'package:quiz_prokit/services/api/etudiant_note_service.dart';
import '../services/connection_service.dart';

class EtudiantNoteData {
  EtudiantNoteManager etudiantNoteManager = EtudiantNoteManager();
  EtudiantNoteApiService etudiantNoteApiService = EtudiantNoteApiService();

  Future<EtudiantNote?> getOneEtudiantData(
      String etudiantId, String periodeId) async {
    if (await ConnectionService.isConnected()) {
      var data = await etudiantNoteApiService.getData(etudiantId, periodeId);
      updateEtudiantNote(data);
      return data;
    } else {
      return await etudiantNoteManager.getOndeEtudiantData(
          etudiantId, periodeId);
    }
  }

  Future<void> updateEtudiantNote(EtudiantNote? data) async {
    if (data != null) {
      await etudiantNoteManager.updateData(data);
    }
  }
}
