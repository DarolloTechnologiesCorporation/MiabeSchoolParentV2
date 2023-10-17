import 'package:quiz_prokit/model/etudiant_compta.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class EtudiantComptaService {
  ApiService apiService = ApiService();

  Future<List<EtudiantCompta>?> getData() async {
    return apiService
        .getApiRequest<EtudiantCompta>((json) => EtudiantCompta.fromJson(json));
  }
}
