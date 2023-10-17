import 'package:dots_indicator/dots_indicator.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/indicator.dart';
import 'package:quiz_prokit/Screens/paiement.dart';
import 'package:quiz_prokit/middleware/etudiant_compta_middleware.dart';
import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/model/etudiant_compta.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';

class OPDasboardScreen extends StatefulWidget {
  @override
  OPDasboardScreenState createState() => OPDasboardScreenState();
}

class OPDasboardScreenState extends State<OPDasboardScreen> {
  // List<OPPickVerifyModel> allCardList = getAllCardListItems();
  List<EtudiantCompta> etudiantCompta = [];
  // List<OPPickVerifyModel> transactionList = getTransactionListItems();

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  bool isBusy = false;
  bool selectedChidlChange = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  int selectedEtudiantIndex = 0;

  EtudiantComptaData etudiantComptaData = EtudiantComptaData();
  Future<void> getData() async {
    setState(() {
      isBusy = true;
    });
    try {
      var temp = await etudiantComptaData.getData();

      setState(() {
        etudiantCompta = temp.validate();
        isBusy = false;
      });
    } catch (e) {
      setState(() {
        isBusy = true;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        etudiantCompta.length > 0
            ? Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 250.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            animateToClosest: true,
                            enlargeFactor: 0.3,
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              setState(() {
                                selectedEtudiantIndex = index;
                              });
                            },
                          ),
                          items: etudiantCompta.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: context.width(),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 16, top: 16),
                                  decoration:
                                      BoxDecoration(color: quiz_colorPrimary),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Image.asset(
                                                  'assets/image/etudicon.png',
                                                  height: 40,
                                                  width: 40),
                                              Text("${i.EtudiantMatricule}",
                                                  style: boldTextStyle(
                                                      size: 20,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          8.height,
                                          FittedBox(
                                            child: Text(
                                              "${i.EtudiantNom} ${i.EtudiantPrenom}",
                                              style: boldTextStyle(
                                                  size: 20,
                                                  color: Colors.white,
                                                  letterSpacing: 3,
                                                  wordSpacing: 2),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          16.height,
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              FittedBox(
                                                child: Text(
                                                  'Ecolage payé',
                                                  style: secondaryTextStyle(
                                                      color: Colors.white60),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              8.height,
                                              FittedBox(
                                                child: Text(
                                                  "${i.EtudiantTotalPaye} Fcfa",
                                                  style: primaryTextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              FittedBox(
                                                child: Text(
                                                  'Ecolage restant',
                                                  style: secondaryTextStyle(
                                                      color: Colors.white60),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "${i.EtudiantTotalRestant} FCFA",
                                                  style: primaryTextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        etudiantCompta.length != 0
                            ? DotsIndicator(
                                dotsCount: etudiantCompta.length,
                                position: selectedEtudiantIndex,
                                decorator: DotsDecorator(
                                  activeColor: quiz_colorAccent,
                                  size: const Size.square(9.0),
                                  activeSize: const Size(12.0, 12.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side:
                                          BorderSide(color: quiz_colorAccent)),
                                ),
                              )
                            : Container(),
                        !selectedChidlChange
                            ? ExpansionTileCard(
                                animateTrailing: true,
                                title: const Text("Paiements efféctués"),
                                children: [
                                  Container(
                                    height: 250,
                                    child: SingleChildScrollView(
                                      child: ListView.separated(
                                        separatorBuilder: (_, index) =>
                                            Divider(),
                                        padding: EdgeInsets.all(8),
                                        itemCount: 12,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // OPPickVerifyModel data = transactionList[index];

                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 16, right: 16, bottom: 8),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.green
                                                                  .withOpacity(
                                                                      0.2),
                                                          radius: 20,
                                                          child: Icon(Icons.abc,
                                                              color:
                                                                  Colors.green,
                                                              size: 20),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                "data.cardTitle",
                                                                style:
                                                                    primaryTextStyle(
                                                                  //  fontFamily: fontMedium,
                                                                  size: 18,
                                                                )),
                                                            SizedBox(height: 4),
                                                            Text(
                                                                "data.cardSubTitle!",
                                                                style:
                                                                    secondaryTextStyle(
                                                                        size:
                                                                            12)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          SizedBox(height: 10),
                                                          Text(
                                                              "data.cardNumber!",
                                                              style:
                                                                  boldTextStyle(
                                                                //color: data.cardColor,
                                                                size: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ).onTap(() {
                                            //OPTransactionDetailsScreen().launch(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        !selectedChidlChange
                            ? ExpansionTileCard(
                                animateTrailing: true,
                                title: const Text("Paiements non effectués"),
                                children: [
                                  Container(
                                    height: 250,
                                    child: SingleChildScrollView(
                                      child: ListView.separated(
                                        separatorBuilder: (_, index) =>
                                            Divider(),
                                        padding: EdgeInsets.all(8),
                                        itemCount: 12,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // OPPickVerifyModel data = transactionList[index];

                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 16, right: 16, bottom: 8),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.green
                                                                  .withOpacity(
                                                                      0.2),
                                                          radius: 20,
                                                          child: Icon(Icons.abc,
                                                              color:
                                                                  Colors.green,
                                                              size: 20),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                "data.cardTitle",
                                                                style:
                                                                    primaryTextStyle(
                                                                  //  fontFamily: fontMedium,
                                                                  size: 18,
                                                                )),
                                                            SizedBox(height: 4),
                                                            Text(
                                                                "data.cardSubTitle!",
                                                                style:
                                                                    secondaryTextStyle(
                                                                        size:
                                                                            12)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          SizedBox(height: 10),
                                                          Text(
                                                              "data.cardNumber!",
                                                              style:
                                                                  boldTextStyle(
                                                                //color: data.cardColor,
                                                                size: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ).onTap(() {
                                            //OPTransactionDetailsScreen().launch(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Container(
                  child: isBusy
                      ? MiabeSchoolIndicatorView()
                      : Text("Aucune information disponible."),
                ),
              )
      ]),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        splashColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (() {
          AddPaiement().launch(context);
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
