import 'package:quiz_prokit/managers/notification_manager.dart';
import 'package:quiz_prokit/model/notification.dart';
import 'package:quiz_prokit/services/api/notification_service.dart';

import '../services/connection_service.dart';

class NotificationModelData {
  NotificationModelManager notificationManager = NotificationModelManager();
  NotificationModelApiService notificationApiService =
      NotificationModelApiService();

  Future<List<NotificationModel>?> getData() async {
    try {
      if (await ConnectionService.isConnected()) {
        var data = await notificationApiService.getData();
        if (data != null) {
          updateNotificationModel(data);
          return data;
        }
        return await notificationManager.getData();
      }
      return await notificationManager.getData();
    } catch (e) {
      return await notificationManager.getData();
    }
  }

  Future<void> updateNotificationModel(List<NotificationModel>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await notificationManager.updateData(element);
      });
    }
  }
}
