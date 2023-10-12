import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:quiz_prokit/utils/QuizWidget.dart';

class QuizEditProfile extends StatefulWidget {
  static String tag = '/QuizEditProfile';

  @override
  _QuizEditProfileState createState() => _QuizEditProfileState();
}

class _QuizEditProfileState extends State<QuizEditProfile> {
  String nom = "", prenom = "", contact = "";

  getData() async {
    var nomTemp = await PreferenceService.getParentNom();
    var prenomTemp = await PreferenceService.getParentPrenom();
    var contactTemp = await PreferenceService.getParentContact();

    setState(() {
      nom = nomTemp.validate();
      prenom = prenomTemp.validate();
      contact = contactTemp.validate();
    });
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  sendData() async {
    if (nom == "" || prenom == "" || contact == "") {
      ToastHelper.showTost("Vérifiez les champs.", ToastType.ERROR, context);
    } else {
      try {
        var updateModel = UpdateInfoDTO();
        updateModel.Nom = nom;
        updateModel.Password = prenom;
        updateModel.Contact = contact;
        var rep = await AuthService().updateInfo(updateModel);
        if (rep) {
          ToastHelper.showTost("Informations modifiées avec succès.",
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

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Imgview = Container(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: quiz_white, width: 4)),
                child: CircleAvatar(
                    backgroundImage: AssetImage("assets/image/etudicon.png"),
                    radius: MediaQuery.of(context).size.width / 8.5),
              ),
            ],
          ).paddingOnly(top: 8),
        ],
      ),
    ).center();

    return Scaffold(
      appBar: AppBar(
        title: text("Modification de vos informations",
            fontSize: 17.0, fontFamily: fontMedium),
        leading: Icon(Icons.arrow_back, color: quiz_colorPrimary, size: 30)
            .onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Imgview,
              SizedBox(height: 20),
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
                          initialValue: nom,
                          onChanged: ((value) {
                            setState(() {
                              nom = value;
                            });
                          }),
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: "Votre nom",
                            border: InputBorder.none,
                            hintStyle: primaryTextStyle(),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(24.0),
                      decoration: boxDecoration(
                          bgColor: context.cardColor,
                          showShadow: true,
                          radius: 10),
                      child: TextFormField(
                        initialValue: prenom,
                        onChanged: ((value) {
                          setState(() {
                            prenom = value;
                          });
                        }),
                        style: primaryTextStyle(),
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                          hintText: "Votre prénom",
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
                        initialValue: contact,
                        onChanged: ((value) {
                          setState(() {
                            contact = value;
                          });
                        }),
                        style: primaryTextStyle(),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                          hintText: "Contact",
                          border: InputBorder.none,
                          hintStyle: primaryTextStyle(),
                        ),
                      ),
                    ),
                    quizDivider(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(50.0),
                child: quizButton(
                  textContent: "Valider",
                  onPressed: () {
                    setState(() {
                      sendData();
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
