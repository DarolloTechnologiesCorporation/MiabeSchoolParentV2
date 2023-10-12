import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/helpers/toast_helper.dart';
import 'package:quiz_prokit/model/authModel.dart';
import 'package:quiz_prokit/services/api/authService.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

class QuizChangePassword extends StatefulWidget {
  static String tag = '/QuizChangePassword';

  @override
  _QuizChangePasswordState createState() => _QuizChangePasswordState();
}

class _QuizChangePasswordState extends State<QuizChangePassword> {
  var oldObscureText = true;
  var newObscureText = true;
  var confirmObscureText = true;
  String oldPassword = "", newPassword = "", confirmNewPassword = "";

  sendData() async {
    if (oldPassword == "" || newPassword == "" || confirmNewPassword == "") {
      ToastHelper.showTost("Vérifiez les champs.", ToastType.ERROR, context);
    } else {
      if (newPassword != confirmNewPassword) {
        ToastHelper.showTost("Les nouveaux mot de passe ne correspondent pas.",
            ToastType.ERROR, context);
      } else {
        try {
          var updateModel = UpdateInfoDTO();
          updateModel.OldPassword = oldPassword;
          updateModel.Password = newPassword;
          var rep = await AuthService().updateInfo(updateModel);
          if (rep) {
            ToastHelper.showTost("Mot de passe modifié avec succès.",
                ToastType.SUCCESS, context);
          } else {
            ToastHelper.showTost(
                "Erreur lors de la modification.", ToastType.ERROR, context);
          }
        } catch (e) {
          ToastHelper.showTost(
              "Erreur lors de la modification.", ToastType.ERROR, context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text("Changer votre mot de passe",
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
                16.height,
                Text(
                  'Saisissez votre ancien mot de passe\n et le nouveau mot de passe.',
                  style: boldTextStyle(color: quiz_textColorSecondary),
                  textAlign: TextAlign.center,
                ).center(),
                Container(
                  margin: EdgeInsets.all(24.0),
                  decoration: boxDecoration(
                      bgColor: context.cardColor, showShadow: true, radius: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                            fontSize: textSizeMedium, fontFamily: fontRegular),
                        obscureText: oldObscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                          border: InputBorder.none,
                          hintText: "Ancien mot de passe",
                          labelStyle: primaryTextStyle(
                              size: 20, color: quiz_textColorPrimary),
                          suffix: text(oldObscureText ? "Voir" : "Cacher",
                                  textColor: quiz_textColorSecondary,
                                  fontSize: textSizeMedium,
                                  fontFamily: fontMedium)
                              .onTap(
                            () {
                              setState(
                                () {
                                  oldObscureText = !oldObscureText;
                                },
                              );
                            },
                          ),
                          //suffixText: (obscureText ? "show" : "hide")
                        ),
                      ),
                      quizDivider(),
                      TextFormField(
                        style: TextStyle(
                            fontSize: textSizeMedium, fontFamily: fontRegular),
                        obscureText: newObscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                          border: InputBorder.none,
                          hintText: "Nouveau mot de passe",
                          labelStyle: primaryTextStyle(
                              size: 20, color: quiz_textColorPrimary),
                          suffix: text(newObscureText ? "Voir" : "Cacher",
                                  textColor: quiz_textColorSecondary,
                                  fontSize: textSizeMedium,
                                  fontFamily: fontMedium)
                              .onTap(
                            () {
                              setState(
                                () {
                                  newObscureText = !newObscureText;
                                },
                              );
                            },
                          ),
                          //suffixText: (obscureText ? "show" : "hide")
                        ),
                      ),
                      quizDivider(),
                      TextFormField(
                        style: TextStyle(
                            fontSize: textSizeMedium, fontFamily: fontRegular),
                        obscureText: confirmObscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                          border: InputBorder.none,
                          hintText: "Confirmer le nouveau mot de passe",
                          labelStyle: primaryTextStyle(
                              size: 20, color: quiz_textColorPrimary),
                          suffix: text(confirmObscureText ? "Voir" : "Cacher",
                                  textColor: quiz_textColorSecondary,
                                  fontSize: textSizeMedium,
                                  fontFamily: fontMedium)
                              .onTap(
                            () {
                              setState(
                                () {
                                  confirmObscureText = !confirmObscureText;
                                },
                              );
                            },
                          ),
                          //suffixText: (obscureText ? "show" : "hide")
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.all(50.0),
                  child: quizButton(
                    textContent: "Modifier",
                    onPressed: () {
                      setState(
                        () {
                          finish(context);
                          toasty(context, quiz_Password_Updated);
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
