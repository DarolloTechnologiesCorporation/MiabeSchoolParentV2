import 'package:quiz_prokit/services/api/api_service.dart';

import '../../model/etudiant_paiement.dart';

class EtudiantPaiementService {
  ApiService apiService = ApiService();

  Future<List<EtudiantPaiement>?> getData() async {
    return apiService.getApiRequest<EtudiantPaiement>(
        (json) => EtudiantPaiement.fromJson(json));
  }
}
