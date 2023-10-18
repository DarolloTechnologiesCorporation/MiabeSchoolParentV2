import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/services/api/preference_service.dart';
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

  static void SubscribeForConnectionChange() async {
    SignalRService.initPlatformState();
    Connectivity().onConnectivityChanged.listen((result) async {
    var connexion = await PreferenceService.getConnexionPreference();
      if (result != ConnectivityResult.none) {
        if (!BackgroundService.isServiceRunning) {
          SignalRService.initPlatformState();
        }
      } else {
        SignalRService.stopHub();
        if (connexion.validate()) {
          await NotificationService.showNotification(
              title: "Miabe school", body: "Vous êtes déconnecté de l'école.");
        }
      }
    });
  }
}
