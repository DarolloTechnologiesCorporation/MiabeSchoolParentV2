import 'package:quiz_prokit/model/composition.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class CompositionApiService {
  ApiService apiService = ApiService();

  Future<List<Composition>?> getData() async {
    return apiService.getApiRequest<Composition>((json) => Composition.fromJson(json));
  }
}
