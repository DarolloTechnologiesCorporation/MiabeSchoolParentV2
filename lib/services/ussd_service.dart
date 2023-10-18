import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class USSDService {
  static Future<int?> getSubscriptionId({required int mnc}) async {
    SimData simData = await SimDataPlugin.getSimData();
    if (simData.cards.length < 2) {
      return -3;
    } else {
      int? sus0;
      int? sus1;
      SimCard sim0 = simData.cards[0];
      SimCard sim1 = simData.cards[1];

      if (sim0.subscriptionId == 0 || sim1.subscriptionId == 0) {
        sus0 = sim0.subscriptionId + 1;
        sus1 = sim1.subscriptionId + 1;
      }

      if (sim0.mnc == mnc) {
        return sus0;
      } else if (sim1.mnc == mnc) {
        return sus0;
      } else {
        return -3;
      }
    }
  }

  static Future<String?> makeMyRequest({
    required String code,
  }) async {
    String? rep = "";
    try {
      await Permission.phone.request();
      if (!await Permission.phone.isGranted) {
        throw Exception("permission missing");
      }

      try {
        String simName = "MOOV";
        if (code.contains("*145*")) {
          simName = "TOGOCEL";
        }
        int mnc = await getSimMNC(simName);
        int? suscriptionId = await getSubscriptionId(mnc: mnc);

        if (suscriptionId != null) {
          try {
            if (suscriptionId == -3) {
              await UssdAdvanced.sendUssd(code: code);
            } else {
              await UssdAdvanced.sendUssd(
                  code: code, subscriptionId: suscriptionId);
            }
          } catch (e) {
            print(e);
          }
        } else {
          print("suscriptionId null");
        }
      } catch (e) {
        print(e);
        return null;
      }
    } catch (e) {
      print(e);
    }
    return rep;
  }

  static Future<int> getSimMNC([String simCarrierName = "TOGOCEL"]) async {
    try {
      SimData simData = await SimDataPlugin.getSimData();
      if (simData.cards.isNotEmpty) {
        for (var element in simData.cards) {
          if (element.carrierName == simCarrierName) {
            return element.mnc;
          }
        }
        int mnc = simData.cards[0].mnc;
        return mnc;
      } else {
        int mnc = -10;
        return mnc;
      }
    } catch (e) {
      throw ("Une erreur s'est produite lors de la récupération des informations de la carte SIM : $e");
    }
  }

  static Future<void> getSimName() async {
    SimData simData = await SimDataPlugin.getSimData();
    print(simData.cards[0].displayName);
  }
}
