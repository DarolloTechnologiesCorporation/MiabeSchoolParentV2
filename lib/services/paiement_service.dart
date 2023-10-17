import 'dart:async';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/services/api/api_service.dart';
import 'package:quiz_prokit/services/notification_service.dart';

class PaiementService {
  static bool isInitialize = false;

  static initPaiementServiceHandler() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (isInitialize) {
        smsHandling();
      }
    });
  }

  static final SmsQuery _query = SmsQuery();

  static smsHandling([String adresse = "TMoney"]) async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(kinds: [
        SmsQueryKind.inbox,
      ], address: adresse);
      messages.forEach((element) async {
        if (element.date != null) {
          if (element.date!.difference(DateTime.now()) <=
              Duration(minutes: Constant.PaiementHandlingDelay)) {
            var rep = await ApiService().addPaiement();
            if (rep) {
              await NotificationService.showNotification(
                  title: "Miabe school",
                  body: "Paiement enrégistré avec succès.");
            }
            else{
              
            }
          }
        }
      });
    } else {
      var rep = await Permission.sms.request();
      if (rep.isGranted) {
        smsHandling();
      }
    }
  }
}
