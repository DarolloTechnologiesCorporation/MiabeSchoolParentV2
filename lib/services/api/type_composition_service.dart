import 'package:quiz_prokit/model/type_composition.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class TypeCompositionApiService {
  ApiService apiService = ApiService();

  Future<List<TypeComposition>?> getData() async {
    return apiService.getApiRequest<TypeComposition>((json) => TypeComposition.fromJson(json));
  }
}
