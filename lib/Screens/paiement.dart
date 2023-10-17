import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/Screens/paiement_etapes/LSCompleteComponent.dart';
import 'package:quiz_prokit/Screens/paiement_etapes/LSDateTimeComponent.dart';
import 'package:quiz_prokit/Screens/paiement_etapes/LSPaymentComponent.dart';
import 'package:quiz_prokit/helpers/toast_helper.dart';
import 'package:quiz_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/model/paiement_model.dart';
import 'package:quiz_prokit/services/ussd_service.dart';

import '../../utils/LSColors.dart';

class AddPaiement extends StatefulWidget {
  static String tag = '/AddPaiement';

  @override
  AddPaiementState createState() => AddPaiementState();
}

class AddPaiementState extends State<AddPaiement> {
  bool isDateTime = true;
  bool isPayment = false;
  bool isComplete = false;
  bool isBusy = false;
  String btnTitle = 'Suivant'.toUpperCase();
  final SmsQuery _query = SmsQuery();

  @override
  void initState() {
    super.initState();
  }

  addPaiement() async {
    // if (tempPaiementModel.EtudiantId == "" ||
    //     tempPaiementModel.EtudiantName == "" ||
    //     tempPaiementModel.PaiementFee == "" ||
    //     tempPaiementModel.PaiementMethod == "" ||
    //     tempPaiementModel.PaiementNumber == "" ||
    //     tempPaiementModel.Price == "") {
    //   ToastHelper.showTost(
    //       "Erreur vérifiez vos entrées.", ToastType.ERROR, context);
    // } else {
    //   try {
    //     var rep = USSDService.makeMyRequest(code: "*06#");
    //   } catch (e) {
    //     ToastHelper.showTost(
    //         "Erreur lors du paiement.", ToastType.ERROR, context);
    //   }
    // }
    try {
      setState(() {
        isBusy = true;
      });
      var rep = await USSDService.makeMyRequest(code: "*06#");
      if (rep != null) {}
    } catch (e) {
      ToastHelper.showTost(
          "Erreur lors du paiement.", ToastType.ERROR, context);
    }
    setState(() {
      isBusy = false;
    });
  }

  smsHandling([String adresse = "TMoney"]) async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(kinds: [
        SmsQueryKind.inbox,
      ], address: adresse);
      ToastHelper.showTost("${messages.length}.", ToastType.ERROR, context);
    } else {
      var rep = await Permission.sms.request();
      if (rep.isGranted) {
        smsHandling();
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        'Paiement',
        elevation: 0.0,
        center: true,
        color: context.cardColor,
        bottom: PreferredSize(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 8),
                      padding: EdgeInsets.all(12),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: isDateTime ? LSColorPrimary : grey,
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(Icons.person, color: white),
                    ),
                    Text('Enfants',
                        style: primaryTextStyle(
                            color: isDateTime
                                ? LSColorPrimary
                                : appStore.isDarkModeOn
                                    ? white
                                    : black)),
                  ],
                ).onTap(() {
                  isDateTime = true;
                  isPayment = false;
                  isComplete = false;
                  btnTitle = 'Suivant'.toUpperCase();
                  setState(() {});
                },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                Container(height: 2, color: lightGrey).expand(),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 8),
                      padding: EdgeInsets.all(12),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: isPayment ? LSColorPrimary : grey,
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(Icons.payment, color: white),
                    ),
                    Text('Paiement',
                        style: primaryTextStyle(
                            color: isPayment
                                ? LSColorPrimary
                                : appStore.isDarkModeOn
                                    ? white
                                    : black)),
                  ],
                ).onTap(() {
                  isDateTime = true;
                  isPayment = true;
                  isComplete = false;
                  btnTitle = 'Suivant'.toUpperCase();
                  setState(() {});
                },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                Container(height: 2, color: lightGrey).expand(),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 8),
                      padding: EdgeInsets.all(12),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: isComplete ? LSColorPrimary : grey,
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(Icons.check, color: white),
                    ),
                    Text('Vérification',
                        style: primaryTextStyle(
                            color: isComplete
                                ? LSColorPrimary
                                : appStore.isDarkModeOn
                                    ? white
                                    : black)),
                  ],
                ).onTap(() {
                  isDateTime = true;
                  isPayment = true;
                  isComplete = true;
                  btnTitle = 'Valider'.toUpperCase();
                  setState(() {});
                },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
              ],
            ).paddingAll(16),
            preferredSize: Size(context.width(), 100)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                LSDateTimeComponent()
                    .visible(isDateTime && !isPayment && !isComplete),
                LSPaymentComponent()
                    .visible(isDateTime && isPayment && !isComplete),
                LSCompleteComponent()
                    .visible(isDateTime && isPayment && isComplete)
              ],
            ),
          ),
          Visibility(
            child: MiabeSchoolIndicatorView(),
            visible: isBusy,
          )
        ],
      ),
      bottomNavigationBar: AppButton(
          width: context.width(),
          color: LSColorPrimary,
          textColor: white,
          text: btnTitle,
          onTap: () {
            if (!isDateTime && !isPayment && !isComplete) {
              isDateTime = true;
              btnTitle = 'Suivant'.toUpperCase();
              setState(() {});
            } else if (isDateTime && !isPayment && !isComplete) {
              isPayment = true;
              btnTitle = 'Suivant'.toUpperCase();
              setState(() {});
            } else if (isDateTime && isPayment && !isComplete) {
              isComplete = true;
              btnTitle = 'Valider'.toUpperCase();
              setState(() {});
            } else {
              //addPaiement();
              smsHandling();
            }
          }).paddingAll(16),
    );
  }
}
