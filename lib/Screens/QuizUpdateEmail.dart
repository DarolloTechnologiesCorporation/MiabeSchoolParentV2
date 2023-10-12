import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/helpers/toast_helper.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:quiz_prokit/services/api/authService.dart';
import 'package:quiz_prokit/services/api/preference_service.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

class QuizUpdateEmail extends StatefulWidget {
  static String tag = '/QuizUpdateEmail';

  @override
  _QuizUpdateEmailState createState() => _QuizUpdateEmailState();
}

class _QuizUpdateEmailState extends State<QuizUpdateEmail> {
  String pseudo = "";

  getData() async {
    var pseudoTemp = await PreferenceService.GetParendPseudo();
    setState(() {
      pseudo = pseudoTemp.validate();
    });
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  sendData() async {
    if (pseudo != "") {
      try {
        var model = UpdateInfoDTO();
        var rep = await AuthService().updateInfo(model);
        if (rep) {
          ToastHelper.showTost(
              "Modifcation effectué avec succès.", ToastType.SUCCESS, context);
        } else {
          ToastHelper.showTost(
              "Erreur lors de la modifcation.", ToastType.ERROR, context);
        }
      } catch (e) {
        ToastHelper.showTost(
            "Erreur lors de la modifcation.", ToastType.ERROR, context);
      }
    } else {
      ToastHelper.showTost("Vérifez le champ.", ToastType.ERROR, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text("Modifiez votre pseudo",
            fontSize: 17.0, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: quiz_colorPrimary, size: 24),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(24.0),
                        decoration: boxDecoration(
                            bgColor: context.cardColor,
                            showShadow: true,
                            radius: 10),
                        child: TextFormField(
                          initialValue: pseudo,
                          onChanged: (value) {
                            setState(() {
                              pseudo = value;
                            });
                          },
                          style: primaryTextStyle(),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            border: InputBorder.none,
                            hintStyle: primaryTextStyle(),
                            hintText: "Votre pseudo",
                            labelStyle: primaryTextStyle(
                                size: 20, color: quiz_textColorPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(50.0),
                  child: quizButton(
                    textContent: "Modifier",
                    onPressed: () {
                      setState(
                        () {
                          sendData();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
