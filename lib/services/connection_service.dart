import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quiz_prokit/services/background_service.dart';
import 'package:quiz_prokit/services/notification_service.dart';
import 'package:quiz_prokit/services/signalr_service.dart';

class ConnectionService {
  static getConnectionState() async =>
      await (Connectivity().checkConnectivity());

  static isConnected() async {
    var result = await getConnectionState();
    if (result != ConnectivityResult.none) return true;
    return false;
  }

  static void SubscribeForConnectionChange() {
    SignalRService.initPlatformState();
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        if (!BackgroundService.isServiceRunning) {
          SignalRService.initPlatformState();
        }
      } else {
        SignalRService.stopHub();
        await NotificationService.showNotification(
            title: "Miabe school", body: "Vous êtes déconnecté de l'école.");
      }
    });
  }
}
