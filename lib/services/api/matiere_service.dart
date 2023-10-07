import 'package:quiz_prokit/model/matiere.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class MatiereApiService {
  ApiService apiService = ApiService();

  Future<List<Matiere>?> getData() async {
    return apiService.getApiRequest<Matiere>((json) => Matiere.fromJson(json));
  }
}
