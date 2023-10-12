import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/middleware/etudiant_note_data_middleware.dart';
import 'package:quiz_prokit/model/etudiant_note.dart';

class QuizCards extends StatefulWidget {
  QuizCards({Key? key, required this.etudiantId, required this.periodeId})
      : super(key: key);
  String? etudiantId, periodeId;

  @override
  State<QuizCards> createState() =>
      _QuizCardsState(etudiantId: etudiantId, periodeId: periodeId);
}

class _QuizCardsState extends State<QuizCards> {
  String? etudiantId, periodeId;
  EtudiantNote? etudiantNote;

  _QuizCardsState({required this.etudiantId, required this.periodeId});

  var etudiantNoteData = new EtudiantNoteData();
  late List<String> matieres;
  late List<String> typeCompotisions;
  late List<String> allNotes;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    etudiantNote = await etudiantNoteData.getOneEtudiantData(
        etudiantId.validate(), periodeId.validate());
    setState(() {
      matieres = etudiantNote!.Matieres.split(";").validate();
      typeCompotisions = etudiantNote!.TypeCompositions.split(";").validate();
      allNotes = etudiantNote!.Notes.split(";").validate();
      // notes = NoteHelper.transformData(temp.validate());
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
                  FixedColumnWidget(matiers: matieres.validate()),
                  ScrollableColumnWidget(
                      notes: allNotes, typeCompositon: typeCompotisions),
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
  List<String> matiers;
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
                  '${matiere}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ))
      ],
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  List<String> typeCompositon;
  List<String> notes;

  ScrollableColumnWidget({required this.typeCompositon, required this.notes});

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
              ...typeCompositon.map((compo) => DataColumn(label: Text(compo))),
            ],
            rows: [
              DataRow(
                cells: [
                  ...notes.validate().map(
                        (e) => DataCell(Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              e.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                      ),
                ],
              )
            ]),
      ),
    );
  }
}
