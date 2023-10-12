import 'package:quiz_prokit/model/etudiant_note.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class EtudiantNoteApiService {
  ApiService apiService = ApiService();

  Future<EtudiantNote?> getData(String etudiantId, String periodeId) async {
    return apiService.getEtudiantNote(etudiantId, periodeId);
  }
}
