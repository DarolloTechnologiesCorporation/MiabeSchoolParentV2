import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizSignIn.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/helpers/toast_helper.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

import '../services/api/authService.dart';
import 'QuizMobileVerify.dart';

class QuizCreatePassword extends StatefulWidget {
  static String tag = '/QuizCreatePassword';

  @override
  _QuizCreatePasswordState createState() => _QuizCreatePasswordState();
}

class _QuizCreatePasswordState extends State<QuizCreatePassword> {
  var obscureText = true;
  String confirmPasswordText = "";
  bool isCorrect = false;
  bool isBussy = false;
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  checkPasswordMatching() {
    if (confirmPasswordText != "" && Constant.registerModel.Password != "") {
      if (confirmPasswordText != Constant.registerModel.Password) {
        ToastHelper.showTost("Les mots de passes ne correspondent pas.",
            ToastType.ERROR, context);
        setState(() {
          isCorrect = false;
        });
      }
    }
    setState(() {
      isCorrect = true;
    });
    return isCorrect;
  }

  Future<void> RegisterUser() async {
    if (isCorrect) {
      setState(() {
        isBussy = true;
      });
      try {
        var pseudoValide = await authService
            .checkPseudoValidity(Constant.registerModel.Pseudo);
        if (!pseudoValide) {
          var rep = await authService.register(Constant.registerModel);
          if (rep) {
            ToastHelper.showTost(
                "Compte créé avec succès.", ToastType.SUCCESS, context);
            QuizSignIn().launch(context);
          } else {
            ToastHelper.showTost("Erreur lors de la création du compte.",
                ToastType.ERROR, context);
          }
        } else {
          ToastHelper.showTost(
              "Ce pseudo est déjà utilisé.", ToastType.ERROR, context);
        }
      } catch (e) {}
      setState(() {
        isBussy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identifiant de connexion", style: boldTextStyle()),
        leading:
            Icon(Icons.arrow_back, color: quiz_colorPrimary, size: 24).onTap(
          () {
            finish(context);
          },
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: !isBussy
            ? Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    height: context.height(),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Votre mot de passe doit avoir 8 caractères ou plus",
                          textAlign: TextAlign.center,
                          style: boldTextStyle(color: quiz_textColorSecondary),
                        ).paddingOnly(left: 40, right: 40, top: 16),
                        16.height,
                        Container(
                          margin: EdgeInsets.all(24.0),
                          decoration: boxDecoration(
                              bgColor: context.cardColor,
                              showShadow: true,
                              radius: 10),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                Constant.registerModel.Pseudo = value;
                              });
                            },
                            style: primaryTextStyle(),
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 22, 16, 22),
                              border: InputBorder.none,
                              hintStyle: primaryTextStyle(),
                              hintText: "Votre pseudo",
                              labelStyle: primaryTextStyle(
                                  size: 20, color: quiz_textColorPrimary),
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
                            style: primaryTextStyle(),
                            obscureText: obscureText,
                            onChanged: ((value) {
                              setState(() {
                                Constant.registerModel.Password = value;
                              });
                            }),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 22, 16, 22),
                              border: InputBorder.none,
                              hintStyle: primaryTextStyle(),
                              hintText: "Votre mot de passe",
                              labelStyle: primaryTextStyle(
                                  size: 20, color: quiz_textColorPrimary),
                              suffix: Text(
                                obscureText ? "Voir" : "Cacher",
                                style: primaryTextStyle(
                                    color: quiz_textColorSecondary),
                              ).onTap(
                                () {
                                  setState(
                                    () {
                                      obscureText = !obscureText;
                                    },
                                  );
                                },
                              ),
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
                            style: primaryTextStyle(),
                            onChanged: ((value) {
                              setState(() {
                                confirmPasswordText = value;
                              });
                            }),
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 22, 16, 22),
                              border: InputBorder.none,
                              hintStyle: primaryTextStyle(),
                              hintText: "Confirmer votre mot de passe",
                              labelStyle: primaryTextStyle(
                                  size: 20, color: quiz_textColorPrimary),
                              suffix: Text(
                                obscureText ? "Voir" : "Cacher",
                                style: primaryTextStyle(
                                    color: quiz_textColorSecondary),
                              ).onTap(
                                () {
                                  setState(
                                    () {
                                      obscureText = !obscureText;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(24.0),
                          child: quizButton(
                            textContent: "Créer mon compte",
                            onPressed: () {
                              if (checkPasswordMatching()) {
                                RegisterUser();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : MiabeSchoolIndicatorView(),
      ),
    );
  }
}
