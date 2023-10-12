import 'package:quiz_prokit/model/notification.dart';
import 'package:quiz_prokit/services/api/api_service.dart';

class NotificationModelApiService {
  ApiService apiService = ApiService();

  Future<List<NotificationModel>?> getData() async {
    return apiService.getApiRequest<NotificationModel>(
        (json) => NotificationModel.fromJson(json));
  }
}
