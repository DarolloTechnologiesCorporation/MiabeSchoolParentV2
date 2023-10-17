/* import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/classe.dart';
// import 'package:quiz_prokit/Screens/calendrier.dart';
//import 'package:quiz_prokit/Screens/esper_booking.dart';
import 'package:quiz_prokit/model/QuizModels.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizDataGenerator.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

import 'QuizCard.dart';

class QuizDetails extends StatefulWidget {
  static String tag = '/QuizDetails';

  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  late List<QuizTestModel> mList;

  @override
  void initState() {
    super.initState();
    mList = quizGetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          quizTopBar(quiz_lbl_biology_basics),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  text(quiz_lbl_biology_amp_scientific_method,
                      isLongText: true,
                      fontFamily: fontBold,
                      isCentered: true,
                      fontSize: textSizeXLarge),
                  text(quiz_text_4_to_8_lesson,
                      textColor: quiz_textColorSecondary),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return quizList(mList[index], index);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class quizList extends StatelessWidget {
  late var width;
  late QuizTestModel model;

  quizList(QuizTestModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    width = context.width();
    return Container(
      margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: boxDecoration(
          radius: 10, showShadow: true, bgColor: context.cardColor),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: quiz_color_setting),
                width: width / 6.5,
                height: width / 6.5,
                padding: EdgeInsets.all(10),
                child: Image.asset(model.image),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.type,
                      style:
                          secondaryTextStyle(color: quiz_textColorSecondary)),
                  4.height,
                  Text(model.heading, style: boldTextStyle()),
                ],
              )
            ],
          ),
          16.height,
          Text(model.description,
              style: primaryTextStyle(color: quiz_textColorSecondary)),
          16.height,

          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: quizButton(
                textContent: quiz_lbl_begin,
                onPressed: () {
                  QuizCards().launch(context);
                }),
          ),
          quizButton(
              textContent: lienCalender,
              onPressed: () {
                Booking().launch(context);
              })
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizCard.dart';
import 'package:quiz_prokit/Screens/classe.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/middleware/periode_data_midleware.dart';
import 'package:quiz_prokit/model/periode.dart';

import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

import '../model/classes.dart';

class QuizDetails extends StatefulWidget {
  QuizDetails({Key? key, required this.etudiantId}) : super(key: key);
  String etudiantId;

  @override
  State<QuizDetails> createState() => _QuizDetailsState(etudiantId: etudiantId);
}

class _QuizDetailsState extends State<QuizDetails> {
  PeriodeData periodeData = PeriodeData();
  String etudiantId;
  String? selectedPeriodeId;
  bool isBusy = false;

  _QuizDetailsState({required this.etudiantId});
  late List<Periode> periodes = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isBusy = true;
    });
    var data = await periodeData.getData(etudiantId);
    setState(() {
      periodes = data.validate();
      isBusy = false;
    });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: periodes.length,
            itemBuilder: (context, index) {
              final periode = periodes[index];
              return GestureDetector(
                child: buildCard(periode, width, context),
                onTap: () {
                  setState(() {
                    selectedPeriodeId = periode.Id;
                  });
                },
              );
            },
          ),
          Visibility(
            child: MiabeSchoolIndicatorView(),
            visible: isBusy,
          ),
        ],
      ),
    );
  }

  Widget buildCard(Periode periode, double width, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue, // Remplacez par quiz_color_setting
                  ),
                  width: width / 6.5,
                  height: width / 6.5,
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons
                      .account_balance_rounded) // Remplacez par le chemin de l'image de l'élève
                  ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(periode.AnneAcademique,
                      style: TextStyle(
                          color:
                              quiz_textColorSecondary)), // Remplacez 'Type' par model.type
                  SizedBox(height: 4),
                  Text(periode.Libelle,
                      style: TextStyle(
                          fontWeight: FontWeight
                              .bold)), // Utilisez le nom du trimestre ici
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: quizButton(
                textContent: quiz_lbl_begin,
                onPressed: () {
                  QuizCards(
                    etudiantId: etudiantId,
                    periodeId: selectedPeriodeId,
                  ).launch(context);
                }),
          ),
          quizButton(
              textContent: lienCalender,
              onPressed: () {
                Booking().launch(context);
              })
        ],
      ),
    );
  }
}
