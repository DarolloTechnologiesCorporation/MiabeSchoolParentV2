import 'package:flutter/material.dart';
import 'package:quiz_prokit/model/paiement_model.dart';
import 'package:quiz_prokit/utils/LSWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/LSColors.dart';

class LSPaymentComponent extends StatefulWidget {
  static String tag = '/LSPaymentComponent';

  @override
  LSPaymentComponentState createState() => LSPaymentComponentState();
}

class LSPaymentComponentState extends State<LSPaymentComponent> {
  int? currentTimeValue = 0;
  int? index = 0;
  // List<LSSelectionModel>? paymentList = [];

  Color starColor = Colors.red;

  addPayementMethodView() {
    const double height = 70;
    const double width = 100;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 100,
      child: Row(
        // This next line does the trick.
        // scrollDirection: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: tempPaiementModel.PaiementMethod == "TMONEY"
                    ? starColor
                    : const Color.fromARGB(0, 209, 70, 70),
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  tempPaiementModel.PaiementMethod = "TMONEY";
                });
              },
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  "assets/image/TMoney.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.5,
                color: tempPaiementModel.PaiementMethod == "Flooz"
                    ? starColor
                    : Colors.transparent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  tempPaiementModel.PaiementMethod = "Flooz";
                });
              },
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  "assets/image/Flooz.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // paymentList!.add(LSSelectionModel(
    //     index: 0, title: 'Pay Via PayPal', subTitle: 'Jhondoe@gmail.com'));
    // paymentList!.add(LSSelectionModel(
    //     index: 1, title: 'Visa Debit Card', subTitle: '**** **** **** 4522'));
    // paymentList!.add(
    //     LSSelectionModel(index: 2, title: 'Cash On Delivery', subTitle: ''));

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: context.height(),
        width: context.width(),
        color: appStore.isDarkModeOn
            ? context.scaffoldBackgroundColor
            : LSColorSecondary.withOpacity(0.55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Méthode de paiement', style: boldTextStyle())
                .paddingOnly(left: 16, right: 16, top: 16),
            20.height,
            Center(
              child: Text(
                "Sélectionnez votre moyen de paiement.",
                style: TextStyle(fontSize: 18),
              ),
            ),
            8.height,
            addPayementMethodView(),
            Text('Moyen de paiement', style: boldTextStyle())
                .paddingOnly(left: 16, right: 16, top: 16),
            Container(
              margin: EdgeInsets.all(12),
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor),
              child: ListView.separated(
                  separatorBuilder: (_, i) {
                    return Divider(thickness: 1);
                  },
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    // LSSelectionModel data = paymentList![i];
                    return Container(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.green.withOpacity(0.2),
                            radius: 20,
                            child:
                                Icon(Icons.abc, color: Colors.green, size: 20),
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("data.cardTitle",
                                  style: primaryTextStyle(
                                    //  fontFamily: fontMedium,
                                    size: 18,
                                  )),
                              SizedBox(height: 4),
                              Text("data.cardSubTitle!",
                                  style: secondaryTextStyle(size: 12)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
