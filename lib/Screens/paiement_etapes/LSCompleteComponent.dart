import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/model/paiement_model.dart';

import '../../main.dart';
import '../../utils/LSColors.dart';
import '../../utils/LSImages.dart';
import '../../utils/LSWidgets.dart';

class LSCompleteComponent extends StatefulWidget {
  static String tag = '/LSCompleteComponent';

  @override
  LSCompleteComponentState createState() => LSCompleteComponentState();
}

class LSCompleteComponentState extends State<LSCompleteComponent> {
  ValueNotifier<int> buttonClickedTimes = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void dispose() {
    buttonClickedTimes.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(),
      width: context.width(),
      color: appStore.isDarkModeOn
          ? context.scaffoldBackgroundColor
          : LSColorSecondary.withOpacity(0.55),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.height,
            Center(
              child: Container(
                child: Icon(
                  Icons.check,
                  size: context.height() * 0.10,
                ),
              ),
            ),
            16.height,
            Text('Récaputilatif sur votre paiement',
                    style: boldTextStyle(size: 20))
                .center(),
            8.height,
            Text('Vérifiez les informations', style: primaryTextStyle())
                .center(),
            Container(
              margin: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Etudiant', style: boldTextStyle()),
                      Text(tempPaiementModel.EtudiantName,
                          style: primaryTextStyle()),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 8),
                  4.height,
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Montant', style: boldTextStyle()),
                      Text(tempPaiementModel.Price + "Fcfa",
                          style: primaryTextStyle()),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 8),
                  4.height,
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frais', style: boldTextStyle()),
                      Text(tempPaiementModel.PaiementFee + "Fcfa",
                          style: primaryTextStyle()),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 8),
                  4.height,
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Numéro', style: boldTextStyle()),
                      Text(tempPaiementModel.PaiementNumber,
                          style: primaryTextStyle()),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 8),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Moyen de paiement', style: boldTextStyle()),
                      Text('Cash Delivery', style: primaryTextStyle()),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 8),
                  16.height,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
