import 'dart:async';
import 'package:quiz_prokit/services/notification_service.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';

class SignalRService {
  static String _serverUrl = "https://66wtb8qg-7252.eun1.devtunnels.ms/hubs";
  static late HubConnection _hubConnection;
  static Future<HubConnection> _getHubConnection() async {
    final logger = Logger("signal R");
    //final logger = null;
    final headers = MessageHeaders();
    headers.setHeaderValue("api-key", "my-top-secret-api-key");
    final httpOptions = new HttpConnectionOptions(
        logger: logger, headers: headers, requestTimeout: 40000);
    //final httpOptions = new HttpConnectionOptions(logger: logger, transport: HttpTransportType.ServerSentEvents);
    //final httpOptions = new HttpConnectionOptions(logger: logger, transport: HttpTransportType.LongPolling);

    _hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: httpOptions)
        /* Configure the Hub with msgpack protocol */
        //.withHubProtocol(MessagePackHubProtocol())
        .withAutomaticReconnect(retryDelays: [1000, 3000, 5000, 7000])
        .configureLogging(logger)
        .build();
    _hubConnection.onclose(({error}) => logger.info("Connection Closed"));
    await Future.delayed(Duration(seconds: 5));
    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
      logger.info("Connection state '${_hubConnection.state}'");
    }
    return _hubConnection;
  }

  static Future<void> stopHub() async {
    await _hubConnection.stop();
  }

  static Future<void> initPlatformState() async {
    final connection = await _getHubConnection();
    if (connection.state == HubConnectionState.Connected) {
      connection.keepAliveIntervalInMilliseconds = 10 * 60 * 60 * 1000;
      await NotificationService.showNotification(
          title: "Miabe school", body: "Vous êtes connecté à l'école.");
      connection.on('DbChange', (message) async {
        await NotificationService.showNotification(
            title: "Miabe school", body: message.toString());
      });
    }
  }
}
