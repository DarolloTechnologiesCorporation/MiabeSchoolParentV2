import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/middleware/etudiant_data_middleware.dart';
import 'package:quiz_prokit/model/etudiant.dart';
import 'package:quiz_prokit/model/paiement_model.dart';

import '../../main.dart';
import '../../utils/LSColors.dart';

class LSDateTimeComponent extends StatefulWidget {
  static String tag = '/LSDateTimeComponent';

  @override
  LSDateTimeComponentState createState() => LSDateTimeComponentState();
}

class LSDateTimeComponentState extends State<LSDateTimeComponent> {
  EtudiantData etudiantData = EtudiantData();
  late List<Etudiant> etudiants = [];
  TextEditingController pickUpDateCont = TextEditingController();
  TextEditingController pickUpTimeCont = TextEditingController();
  TextEditingController deliveryDateCont = TextEditingController();
  TextEditingController deliveryTimeCont = TextEditingController();

  DateTime pickUpDate = DateTime.now();
  TimeOfDay pickUpTime = TimeOfDay.now();
  DateTime deliveryDate = DateTime.now();
  TimeOfDay deliveryTime = TimeOfDay.now();
  bool isBusy = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isBusy = true;
    });
    var temp = await etudiantData.getData();
    // var not = await notificationModelData.getData();
    setState(() {
      etudiants = temp.validate();
      isBusy = false;
      //notificationModels = not.validate();
    });
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: context.height(),
        width: context.width(),
        color: appStore.isDarkModeOn
            ? context.scaffoldBackgroundColor
            : LSColorSecondary.withOpacity(0.55),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FastAutocomplete<Etudiant>(
              name: 'autocomplete',
              labelText: 'Enfant',
              helperText: "Saisissez le nom de votre enfant",
              onSelected: (option) {
                setState(() {
                  tempPaiementModel.EtudiantName =
                      option.Nom + " " + option.Prenom;
                  tempPaiementModel.EtudiantId = option.Id;
                });
              },
              options: etudiants,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<Etudiant>.empty();
                }
                return etudiants.where((option) =>
                    option.Nom.toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()) ||
                    option.Prenom.toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
              },
              displayStringForOption: (option) {
                return option.Nom + " " + option.Prenom;
              },
            ),
            30.height,
            FastAutocomplete<String>(
              name: 'autocomplete',
              onSelected: (option) {
                print(option);
              },
              onSaved: (newValue) {
                print(newValue);
              },
              onChanged: (value) {},
              labelText: 'Frais',
              helperText: "Saisissez les frais que vous voulez payer",
              options: const ['Alaska', 'Alabama', 'Connecticut', 'Delaware'],
            ),
          ],
        ).paddingAll(8),
      ),
    );
  }
}
