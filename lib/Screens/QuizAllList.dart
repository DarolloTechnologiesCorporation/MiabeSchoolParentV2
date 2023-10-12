//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizNotification.dart';
import 'package:quiz_prokit/middleware/etudiant_data_middleware.dart';
import 'package:quiz_prokit/middleware/notification_data_middleware.dart';
import 'package:quiz_prokit/model/QuizModels.dart';
import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/model/notification.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizDataGenerator.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';

import '../main.dart';
import 'QuizDetails.dart';
import 'notification_item.dart';

class QuizAllList extends StatefulWidget {
  static String tag = '/QuizAllList';

  @override
  _QuizAllListState createState() => _QuizAllListState();
}

class _QuizAllListState extends State<QuizAllList> {
  int selectedPos = 1;
  EtudiantData etudiantData = EtudiantData();
  NotificationModelData notificationModelData = NotificationModelData();
  late List<Etudiant> etudiants = [];
  late List<NotificationModel> notificationModels = [];

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    getData();
  }

  void getData() async {
    var temp = await etudiantData.getData();
    // var not = await notificationModelData.getData();
    setState(() {
      etudiants = temp.validate();
      //notificationModels = not.validate();
    });
  }

  Widget quizAll() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      children: etudiants.map((e) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  child: Image.asset(
                    e.Sexe == "MASCULIN"
                        ? "assets/image/profile_boy.png"
                        : "assets/image/profile_girl.png", // Utilisez Icons.person pour représenter une personne
                    height: 70.0, // Taille de l'icône
                    //  color: Colors.black, // Couleur de l'icône
                  )

                  /*CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(
                      BuildContext, String)?,
                  imageUrl: e.quizImage,
                  height: context.width() * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),*/
                  ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  // color: quiz_white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    text("${e.Nom} ${e.Prenom}",
                            fontSize: textSizeMedium,
                            maxLine: 2,
                            fontFamily: fontMedium)
                        .paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(e.Salle, textColor: quiz_textColorSecondary)
                        .paddingOnly(left: 16, right: 16, bottom: 8),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails(etudiantId: e.Id).launch(context);
        });
      }).toList(),
    );
  }

  Widget quizCompleted() {
    return Container(
      padding: EdgeInsets.all(12),
      height: context.height(),
      // color: appStore.isDarkModeOn ? scaffoldDarkColor : gray.withOpacity(0.1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...notificationModels.map((e) => NotificationItem(model: e)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  width: width,
                  decoration: boxDecoration(
                      radius: spacing_middle,
                      bgColor: context.cardColor,
                      showShadow: false),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            selectedPos = 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(spacing_middle),
                                  bottomLeft: Radius.circular(spacing_middle)),
                              color: selectedPos == 1
                                  ? appStore.isDarkModeOn
                                      ? scaffoldDarkColor
                                      : quiz_white
                                  : Colors.transparent,
                              border: Border.all(
                                  color: selectedPos == 1
                                      ? quiz_white
                                      : Colors.transparent),
                            ),
                            child: text(
                              quiz_lbl_All,
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 1
                                  ? appStore.isDarkModeOn
                                      ? white
                                      : quiz_textColorPrimary
                                  : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(height: 40, width: 1, color: quiz_light_gray)
                          .center(),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPos = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(spacing_middle),
                                  bottomRight: Radius.circular(spacing_middle)),
                              color: selectedPos == 2
                                  ? appStore.isDarkModeOn
                                      ? scaffoldDarkColor
                                      : quiz_white
                                  : Colors.transparent,
                              border: Border.all(
                                  color: selectedPos == 2
                                      ? quiz_white
                                      : Colors.transparent),
                            ),
                            child: text(
                              "Informations",
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 2
                                  ? appStore.isDarkModeOn
                                      ? white
                                      : quiz_textColorPrimary
                                  : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: selectedPos == 1 ? quizAll() : quizCompleted(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
