import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizDashboard.dart';
import 'package:quiz_prokit/Screens/QuizVerifcation.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/helpers/toast_helper.dart';
import 'package:quiz_prokit/main.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:quiz_prokit/services/api/authService.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';
import 'package:quiz_prokit/utils/codePicker/country_code_picker.dart';

class QuizMobileVerify extends StatefulWidget {
  static String tag = '/QuizMobileVerify';

  @override
  _QuizMobileVerifyState createState() => _QuizMobileVerifyState();
}

class _QuizMobileVerifyState extends State<QuizMobileVerify> {
  String nom = "", prenom = "", matricule = "";
  AuthService authService = AuthService();
  bool isBusy = false;
  sendData() async {
    try {
      setState(() {
        isBusy = true;
      });
      if (nom != "" && prenom != "" && matricule != "") {
        var rep = await authService.addEleve(ParentAddEleveDTO(
            EleveCode: matricule, EleveNom: nom, ElevePrenom: prenom));
        if (rep) {
          ToastHelper.showTost(
              "Elève ajouté avec succès.", ToastType.SUCCESS, context);
        } else {
          ToastHelper.showTost(
              "Erreur lors de l'ajout de l'élève.", ToastType.ERROR, context);
        }
      } else {
        ToastHelper.showTost("Vérifiez les champs.", ToastType.ERROR, context);
      }
    } catch (e) {
      ToastHelper.showTost(
          "Erreur lors de l'ajout de l'élève.", ToastType.ERROR, context);
    }
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'un élève", style: boldTextStyle()),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: !isBusy
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      16.height,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Saisissez les informations demandées pour ajouter un élève.",
                          style: boldTextStyle(
                            color: quiz_textColorSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ).center(),
                      ),
                      // 16.height,
                      // Container(
                      //   margin: EdgeInsets.all(24.0),
                      //   decoration: boxDecoration(
                      //       bgColor: context.cardColor, showShadow: true, radius: 10),
                      //   child: Row(
                      //     children: <Widget>[
                      //       4.height,
                      //       CountryCodePicker(onChanged: print, showFlag: false),
                      //       Container(
                      //         height: 30.0,
                      //         width: 1.0,
                      //         color: quiz_colorPrimary,
                      //         margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      //       ),
                      //       Expanded(
                      //         child: TextFormField(
                      //           keyboardType: TextInputType.number,
                      //           maxLength: 10,
                      //           style: primaryTextStyle(),
                      //           decoration: InputDecoration(
                      //             contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                      //             counterText: "",
                      //             hintText: quiz_hint_Mobile_Number,
                      //             hintStyle: primaryTextStyle(
                      //                 color: appStore.isDarkModeOn
                      //                     ? white
                      //                     : quiz_textColorPrimary),
                      //             border: InputBorder.none,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // 16.height,
                      Container(
                        margin: EdgeInsets.all(24.0),
                        decoration: boxDecoration(
                            bgColor: context.cardColor,
                            showShadow: true,
                            radius: 10),
                        child: TextFormField(
                          onChanged: ((value) {
                            setState(() {
                              nom = value;
                            });
                          }),
                          style: primaryTextStyle(),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: "Nom",
                            border: InputBorder.none,
                            hintStyle: primaryTextStyle(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(24.0),
                        decoration: boxDecoration(
                            bgColor: context.cardColor,
                            showShadow: true,
                            radius: 10),
                        child: TextFormField(
                          onChanged: ((value) {
                            setState(() {
                              prenom = value;
                            });
                          }),
                          style: primaryTextStyle(),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: "Prénom",
                            border: InputBorder.none,
                            hintStyle: primaryTextStyle(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(24.0),
                        decoration: boxDecoration(
                            bgColor: context.cardColor,
                            showShadow: true,
                            radius: 10),
                        child: TextFormField(
                          onChanged: ((value) {
                            setState(() {
                              matricule = value;
                            });
                          }),
                          style: primaryTextStyle(),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: "Matricule de l'élève",
                            border: InputBorder.none,
                            hintStyle: primaryTextStyle(),
                          ),
                        ),
                      ),

                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 50),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: quizButton(
                          textContent: "Ajouter",
                          onPressed: () {
                            setState(
                              () {
                                sendData();
                                //QuizVerification().launch(context);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            : MiabeSchoolIndicatorView(),
      ),
    );
  }
}
