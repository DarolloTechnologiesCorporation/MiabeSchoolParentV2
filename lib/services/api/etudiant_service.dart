import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class EtudiantApiService {
  ApiService apiService = ApiService();

  Future<List<Etudiant>?> getData() async {
    return apiService.getApiRequest<Etudiant>((json) => Etudiant.fromJson(json));
  }
}
