import 'package:quiz_prokit/services/api/preference_service.dart';
import 'package:quiz_prokit/services/background_service.dart';
import 'package:quiz_prokit/services/notification_service.dart';

class MiabeSchoolService {
  static initMiabeSchoolService() async {
    await NotificationService.initNotification();
    await BackgroundService.initializeService();
    initPreference();
  }

  static initPreference() async {
    var id = await PreferenceService.GetParendId();
    if (id == null) {
      PreferenceService.SetConnexionPreference(true);
      PreferenceService.SetNotificationPreference(true);
    }
  }
}
