import 'package:flutter/material.dart';
//import 'package:nb_utils/nb_utils.dart';

/*
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizResult.dart';
import 'package:quiz_prokit/main.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizCard.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';

class QuizCards extends StatefulWidget {
  static String tag = '/QuizCards';

  @override
  _QuizCardsState createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  List<Widget> cardList = [];

  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    cardList = _generateCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Stack(alignment: Alignment.center, children: cardList),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: Icon(Icons.close, color: quiz_colorPrimary),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: textSecondaryColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        quiz_green,
                      ),
                    ).paddingAll(16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _generateCards() {
    List<Quiz> planetCard = [];
    planetCard.add(
      Quiz("How many basic steps are there in scientific method?",
          "Eight Steps", "Ten Steps", "Two Steps", "One Steps", 70.0),
    );
    planetCard.add(
      Quiz("Which blood vessels have the smallest diameter? ", "Capillaries",
          "Arterioles", "Venules", "Lymphatic", 80.0),
    );
    planetCard.add(Quiz("The substrate of photo-respiration is", "Phruvic acid",
        "Glucose", "Fructose", "Glycolate", 90.0));

    planetCard.add(Quiz("Which one of these animal is jawless?", "Shark",
        "Myxine", "Trygon", "Sphyrna", 100.0));
    planetCard.add(
      Quiz("How many basic steps are there in scientific method?",
          "Eight Steps", "Ten Steps", "One Steps", "Three Steps", 110.0),
    );
    List<Widget> cardList = [];

    for (int x = 0; x < 5; x++) {
      cardList.add(
        Positioned(
          top: planetCard[x].topMargin,
          child: Draggable(
            onDragEnd: (drag) {
              if (x == 0) {
                setState(() {
                  QuizResult().launch(context);
                });
              }
              removeCards(x);
            },
            childWhenDragging: Container(),
            feedback: Material(
              child: GestureDetector(
                child: Container(
                  decoration: boxDecoration(
                      radius: 20, bgColor: quiz_white, showShadow: true),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        width: 320.0,
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: text(planetCard[x].cardImage,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold,
                              isLongText: true),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            children: <Widget>[
                              quizCardSelection("A.", planetCard[x].option1,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("B.", planetCard[x].option2,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("C.", planetCard[x].option3,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("D.", planetCard[x].option4,
                                  () {
                                removeCards(x);
                              }),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            child: GestureDetector(
              child: Container(
                decoration: boxDecoration(
                    radius: 20,
                    bgColor: appStore.isDarkModeOn ? cardDarkColor : white,
                    showShadow: true),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 200.0,
                        width: 320.0,
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: text(planetCard[x].cardImage,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold,
                              isLongText: true),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          quizCardSelection("A.", planetCard[x].option1, () {
                            removeCards(x);
                          }),
                          quizCardSelection("B.", planetCard[x].option2, () {
                            removeCards(x);
                          }),
                          quizCardSelection("C.", planetCard[x].option3, () {
                            removeCards(x);
                          }),
                          quizCardSelection(
                            "D.",
                            planetCard[x].option4,
                            () {
                              removeCards(x);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return cardList;
  }
}

Widget quizCardSelection(var option, var option1, onPressed) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: boxDecoration(
        showShadow: false,
        bgColor: appStore.isDarkModeOn ? cardDarkColor : quiz_edit_background,
        radius: 10,
        color: quiz_view_color,
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      width: 320,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: text(option1, textColor: quiz_textColorSecondary),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: text(option, textColor: quiz_textColorSecondary),
          )
        ],
      ),
    ),
  );
}*/
//import 'package:lazy_data_table/lazy_data_table.dart';

//import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/model/classes.dart';
//import 'package:quiz_prokit/utils/QuizColors.dart';
//import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class QuizCards extends StatefulWidget {
  const QuizCards({Key? key}) : super(key: key);

  @override
  State<QuizCards> createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
      home: Scaffold(
        appBar: AppBar(
          title: Text('Matiéres      Devoir 1       Devoir 2      Composition'),
          toolbarTextStyle: primaryTextStyle(color: quiz_textColorSecondary),
        ),
        body: MyGrid(),
      ),
    );
  }
}

class MyGrid extends StatelessWidget {
  final List<String> matieres = [
    'SVT',
    'Mathématique',
    'Phylosophie',
    'Matiè',
    'physic',
    'H-G',
    'Anglais'
  ];
  final List<List<int>> chiffres = [
    [1, 2, 3, 13],
    [5, 6, 7, 18],
    [9, 10, 11, 9],
    [13, 14, 15, 7],
    [16, 18, 5, 11],
    [3, 9, 18, 0],
    [5, 19, 7, 16],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        int rowIndex = index ~/ 5;
        int colIndex = index % 5;

        if (colIndex == 0) {
          return Center(
            child: Text(
              matieres[rowIndex],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          int chiffre = chiffres[rowIndex][colIndex - 1];
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30.0),
            height: 300.0,
            child: Text(
              chiffre.toString(),
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      },
      itemCount: 7 * 5,
    );*/
      home: Scaffold(
        body: SafeArea(
          child: Container(
            //width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  FixedColumnWidget(),
                  ScrollableColumnWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FixedColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 200,
      headingRowColor: MaterialStateProperty.all(Colors.blue[300]),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      columns: [
        DataColumn(label: Text('Matiére')),
      ],
      rows: [
        ...teamsData.map((team) => DataRow(
              cells: [
                DataCell(Text(
                  '${team.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ))
      ],
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor:
                MaterialStateProperty.all(Color.fromARGB(255, 176, 171, 245)),
            columnSpacing: 40,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            columns: [
              DataColumn(label: Text('Interrogation 1')),
              DataColumn(label: Text('Interrogation 2')),
              DataColumn(label: Text('Devoir 1')),
              DataColumn(label: Text('Devoir 2')),
              DataColumn(label: Text('Composition')),
              //  DataColumn(label: Text('GD')),
            ],
            rows: [
              ...teamsData.map((team) => DataRow(
                    cells: [
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            team.points.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.won.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.lost.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.drawn.toString()))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(team.against.toString()))),
                      //   DataCell(Container(
                      //      alignment: AlignmentDirectional.center,
                      //     child: Text(team.gd.toString()))),
                    ],
                  ))
            ]),
      ),
    );
  }
}
