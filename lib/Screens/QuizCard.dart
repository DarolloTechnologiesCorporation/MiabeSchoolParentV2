import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/helpers/note_herlper.dart';
import 'package:quiz_prokit/middleware/composition_data_middleware.dart';
import 'package:quiz_prokit/model/composition.dart';
import 'package:quiz_prokit/model/matiere.dart';

class QuizCards extends StatefulWidget {
  const QuizCards({Key? key}) : super(key: key);

  @override
  State<QuizCards> createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  late Map<Matiere, Map<Composition, List<String>>> notes = {};
  var compositionData = new CompositionData();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var temp = await compositionData.getData();
    setState(() {
      notes = NoteHelper.transformData(temp.validate());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            //width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  FixedColumnWidget(matiers: notes.keys.validate()),
                  ScrollableColumnWidget(
                      compositions: notes.values.validate()[0]),
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
  List<Matiere> matiers;
  FixedColumnWidget({required this.matiers});

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
        ...matiers.map((matiere) => DataRow(
              cells: [
                DataCell(Text(
                  '${matiere.Libelle}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ))
      ],
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  Map<Composition, List<String>> compositions;

  ScrollableColumnWidget({required this.compositions});

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
              ...compositions.keys.map(
                  (compo) => DataColumn(label: Text(compo.TypeComposition))),
            ],
            rows: [
              ...compositions.values.map((team) => DataRow(
                    cells: [
                      ...team.validate().map(
                            (e) => DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  e.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                          ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
