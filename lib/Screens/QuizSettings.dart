import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizChangePassword.dart';
import 'package:quiz_prokit/Screens/QuizContactUs.dart';
import 'package:quiz_prokit/Screens/QuizEditProfile.dart';
import 'package:quiz_prokit/Screens/QuizHelpCenter.dart';
import 'package:quiz_prokit/Screens/QuizUpdateEmail.dart';
import 'package:quiz_prokit/main.dart';
import 'package:quiz_prokit/services/api/preference_service.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';

class QuizSettings extends StatefulWidget {
  static String tag = '/QuizSetting';

  @override
  _QuizSettingsState createState() => _QuizSettingsState();
}

class _QuizSettingsState extends State<QuizSettings> {
  String name = "";
  String pseudo = "";

  @override
  initState() {
    super.initState();

    getData();
  }

  getData() async {
    var temp = await PreferenceService.GetParendName();
    var temp1 = await PreferenceService.GetParendPseudo();
    var connexion = await PreferenceService.getConnexionPreference();
    var notification = await PreferenceService.getNotificationPreference();
    setState(() {
      name = temp.validate();
      pseudo = temp1.validate();
      notifyConnection = connexion.validate();
      notifyInfo = notification.validate();
    });
  }

  Widget quizSettingOptionPattern1(var settingIcon, var heading, var info) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: quiz_color_setting),
                width: 45,
                height: 45,
                padding: EdgeInsets.all(4),
                child: Icon(settingIcon, color: quiz_white),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    heading,
                    softWrap: true,
                    style: TextStyle(),
                  ),
                  Text(info,
                      style: primaryTextStyle(
                          color: quiz_textColorSecondary, size: 14)),
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: quiz_icon_color,
          )
        ],
      ),
    );
  }

  bool notifyInfo = false;
  bool notifyConnection = false;

  Widget quizSettingOptionPattern3(var icon, var heading) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: quiz_color_setting),
                width: 45,
                height: 45,
                padding: EdgeInsets.all(4),
                child: Icon(
                  icon,
                  color: quiz_white,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(heading),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: quiz_icon_color,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paramètres",
          style: primaryTextStyle(size: 18, fontFamily: fontMedium),
        ),
        iconTheme: IconThemeData(color: quiz_colorPrimary, size: 24),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          quizSettingOptionPattern1(
                                  Icons.info, "Changer vos informations", name)
                              .onTap(() {
                            setState(() {
                              QuizEditProfile().launch(context);
                            });
                          }),
                          quizSettingOptionPattern1(Icons.perm_identity,
                                  "Changer votre pseudo", pseudo)
                              .onTap(() {
                            setState(() {
                              QuizUpdateEmail().launch(context);
                            });
                          }),
                          quizSettingOptionPattern3(
                                  Icons.vpn_key, "Changer votre mot de passe")
                              .onTap(() {
                            setState(() {
                              QuizChangePassword().launch(context);
                            });
                          }),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: quiz_color_setting),
                                      width: 45,
                                      height: 45,
                                      padding: EdgeInsets.all(4),
                                      child: Image.asset('images/ic_theme.png',
                                              height: 24,
                                              width: 24,
                                              color: quiz_white)
                                          .paddingOnly(left: 6),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text('Mode sombre'),
                                  ],
                                ),
                                Switch(
                                  value: appStore.isDarkModeOn,
                                  activeColor: appColorPrimary,
                                  onChanged: (s) {
                                    appStore.toggleDarkMode(value: s);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: quiz_color_setting),
                                      width: 45,
                                      height: 45,
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.notifications,
                                        color: quiz_white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        "Me tenir informer des \npartages d'informations"),
                                  ],
                                ),
                                Switch(
                                  value: notifyInfo,
                                  onChanged: (value) {
                                    setState(() {
                                      notifyInfo = value;
                                    });
                                    PreferenceService.SetNotificationPreference(
                                        notifyInfo);
                                  },
                                  activeTrackColor: quiz_colorPrimary,
                                  activeColor: quiz_view_color,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: quiz_color_setting),
                                      width: 45,
                                      height: 45,
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.notifications_on,
                                        color: quiz_white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        "Me tenir informer de \nl'état de ma connexion"),
                                  ],
                                ),
                                Switch(
                                  value: notifyConnection,
                                  onChanged: (value) {
                                    setState(() {
                                      notifyConnection = value;
                                    });
                                    PreferenceService.SetConnexionPreference(
                                        value);
                                  },
                                  activeTrackColor: quiz_colorPrimary,
                                  activeColor: quiz_view_color,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      child: Text(
                        quiz_lbl_logout,
                        textAlign: TextAlign.end,
                        style:
                            boldTextStyle(color: quiz_colorPrimary, size: 18),
                      ).paddingAll(16).onTap(() {
                        finish(context);
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
