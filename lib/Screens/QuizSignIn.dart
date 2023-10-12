import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizDashboard.dart';
import 'package:quiz_prokit/Screens/QuizSignUp.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/helpers/constant.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:quiz_prokit/services/api/authService.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

import '../helpers/toast_helper.dart';

class QuizSignIn extends StatefulWidget {
  static String tag = '/QuizSignIn';

  @override
  _QuizSignInState createState() => _QuizSignInState();
}

class _QuizSignInState extends State<QuizSignIn> {
  String pseudo = "";
  String password = "";
  bool isBusy = false;
  check() {
    if (password != "" && pseudo != "") return true;
    return false;
  }

  AuthService authService = AuthService();

  register() async {
    try {
      if (check()) {
        setState(() {
          isBusy = true;
        });
        var rep = await authService
            .login(LoginDTO(Pseudo: pseudo, Password: password));
        if (rep) {
          ToastHelper.showTost("Connexion réussie", ToastType.SUCCESS, context);
          QuizDashboard().launch(context);
        } else {
          ToastHelper.showTost(
              "Erreur lors de la connexion", ToastType.ERROR, context);
        }
      } else {
        ToastHelper.showTost(
            "Erreur vérifiez les champs", ToastType.ERROR, context);
      }
    } catch (e) {}
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !isBusy
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      24.height,
                      Text(quiz_title_login, style: boldTextStyle(size: 18)),
                      8.height,
                      Text(quiz_info_login,
                              style: primaryTextStyle(
                                  color: quiz_textColorSecondary))
                          .center(),
                      Container(
                        margin: EdgeInsets.all(24.0),
                        decoration: boxDecoration(
                            bgColor: context.cardColor,
                            showShadow: true,
                            radius: 10),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onChanged: ((value) {
                                setState(() {
                                  pseudo = value;
                                });
                              }),
                              style: primaryTextStyle(),
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 22, 16, 22),
                                hintText: "Votre pseudo",
                                border: InputBorder.none,
                                hintStyle: primaryTextStyle(),
                              ),
                            ),
                            quizDivider(),
                            TextFormField(
                              onChanged: ((value) {
                                setState(() {
                                  password = value;
                                });
                              }),
                              style: primaryTextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 22, 16, 22),
                                hintText: "Votre mot de passe",
                                border: InputBorder.none,
                                hintStyle: primaryTextStyle(),
                              ),
                            )
                          ],
                        ),
                      ),
                      30.height,
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(quiz_lbl_don_t_have_an_account,
                                style: primaryTextStyle()),
                            4.height,
                            Text(quiz_lbl_create_account,
                                style: boldTextStyle(color: quiz_colorPrimary)),
                          ],
                        ),
                      ).onTap(
                        () {
                          setState(
                            () {
                              QuizSignUp().launch(context);
                            },
                          );
                        },
                      ),
                      8.height,
                      Container(
                        margin: EdgeInsets.all(24.0),
                        child: quizButton(
                          textContent: quiz_lbl_continue,
                          onPressed: () {
                            setState(
                              () {
                                register();
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
