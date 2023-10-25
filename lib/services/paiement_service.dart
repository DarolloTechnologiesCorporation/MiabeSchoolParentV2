import 'dart:async';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/managers/failed_paiement_manage.dart';
import 'package:quiz_prokit/model/failed_paiement.dart';
import 'package:quiz_prokit/model/paiement_model.dart';
import 'package:quiz_prokit/services/api/api_service.dart';
import 'package:quiz_prokit/services/api/preference_service.dart';
import 'package:quiz_prokit/services/notification_service.dart';

class PaiementService {
  static DateTime? dateInitialize;
  static bool isInitialize = false;

  static initPaiementServiceHandler() {
    Timer.periodic(const Duration(seconds: 15), (timer) async {
      var rep = await PreferenceService.getPaiementInit();
      if (rep == null) {
        isInitialize = false;
      } else {
        if (rep.validate()) {
          isInitialize = true;
          var date = await PreferenceService.getPaiementInitDate();
          dateInitialize = date;
        }
      }
      if (isInitialize) {
        var adresse = "TMoney";
        if (tempPaiementModel.PaiementMethod != "TMONEY") {
          adresse = "FLooz";
        }
        smsHandling(adresse);
      }

      if (isInitialize) {
        if (dateInitialize != null) {
          if (DateTime.now().difference(dateInitialize!.add(Duration(
                  minutes: Constant.PaiementHandlingVerificationDelay))) >=
              Duration(
                  minutes: Constant.PaiementHandlingVerificationIntervale)) {
            var isNotify = await PreferenceService.getPaiementVerification();
            if (!isNotify.validate()) {
              NotificationService.showNotification(
                  title: "Confirmation de paiement.",
                  body: "Avez vous éffectué le paiement?");
              PreferenceService.setPaiementVerification(true);  
            }
          }
        }
      }
    });
  }

  static initFailedPaiement() async {
    var manager = FailedPaiementModelManager();
    var data = await manager.getData();
    if (data != null)
      data.forEach((element) async {
        tempPaiementModel.EtudiantId = element.PaiementEtudiantId;
        tempPaiementModel.PaiementFee = element.PaiementPrice;
        tempPaiementModel.PaiementFraisId = element.PaiementFraisId;
        tempPaiementModel.PaiementNumber = element.PaiementNumber;
        tempPaiementModel.PaiementReference = element.PaiementReference;
        var rep = await ApiService().addPaiement();
        if (rep) {
          await manager.deleteData(element);
        }
      });
  }

  static final SmsQuery _query = SmsQuery();

  static String getReference(String texte, [String adresse = "TMoney"]) {
    var reponse = "";
    if (adresse == "TMoney") {
      if (texte.contains("Ref:")) {
        reponse = texte.substring(texte.indexOf("Ref: "), 11);
      }
    } else {
      if (texte.contains("Txn ID:")) {
        reponse = texte.substring(texte.indexOf("Txn ID: "), 13);
      }
    }
    return reponse;
  }

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
            if (element.body!.contains(tempPaiementModel.PaiementNumber)) {
              tempPaiementModel.PaiementReference =
                  getReference(element.body!, adresse);
              try {
                var rep = await ApiService().addPaiement();
                if (rep) {
                  await NotificationService.showNotification(
                      title: "Validation du paiement.",
                      body: "Paiement effecuté avec succès.");
                } else {
                  await FailedPaiementModelManager().insertData(
                      FailedPaiementModel(
                          Id: 0,
                          PaiementReference:
                              tempPaiementModel.PaiementReference,
                          PaiementEtudiantId: tempPaiementModel.EtudiantId,
                          PaiementFraisId: tempPaiementModel.PaiementFraisId,
                          PaiementNumber: tempPaiementModel.PaiementNumber,
                          PaiementPrice: tempPaiementModel.PaiementFee));
                }
                PreferenceService.setPaiementInit(false);
                PreferenceService.setPaiementInitDate("");
                tempPaiementModel = PaiementModel();
              } catch (e) {
                await FailedPaiementModelManager().insertData(
                    FailedPaiementModel(
                        Id: 0,
                        PaiementReference: tempPaiementModel.PaiementReference,
                        PaiementEtudiantId: tempPaiementModel.EtudiantId,
                        PaiementFraisId: tempPaiementModel.PaiementFraisId,
                        PaiementNumber: tempPaiementModel.PaiementNumber,
                        PaiementPrice: tempPaiementModel.PaiementFee));
                PreferenceService.setPaiementInit(false);
                PreferenceService.setPaiementInitDate("");
                tempPaiementModel = PaiementModel();
              }
            }
          }
        }
      });
    }
  }
}
