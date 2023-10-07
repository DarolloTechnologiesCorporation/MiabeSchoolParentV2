import 'package:quiz_prokit/model/periode.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class PeriodeApiService {
  ApiService apiService = ApiService();

  Future<List<Periode>?> getData() async {
    return apiService.getApiRequest<Periode>((json) => Periode.fromJson(json));
  }
}
