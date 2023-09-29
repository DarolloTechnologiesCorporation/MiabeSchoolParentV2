import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime today = DateTime.now();
  Map<String, List<String>> subjectsByDate = {
    '2023-09-25': ['Mathématiques', 'Français', 'Physics', 'Chimie', 'Info'],
    '2023-09-26': [
      'Sciences',
      'Histoire',
      'Histoire',
      'Info',
      'Anglais',
      'Math',
      'Math',
      'Biologie',
      'Biologie'
    ],
    '2023-09-27': ['Anglais', 'Sport', 'Biologie', 'Science', 'EPS'],
    '2023-09-20': [
      'SVT',
      'Anglais',
      'Français',
      'H-G',
      'Mathematique',
      'All',
      'Espa'
    ],
  };

  List<String> subjects = [];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

    String selectedDateKey =
        "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";

    List<String> selectedSubjects = subjectsByDate[selectedDateKey] ?? [];

    setState(() {
      subjects = selectedSubjects.isNotEmpty
          ? selectedSubjects
          : ['Aucune matière disponible'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Présence'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(today.toString().split(" ")[0]),
            Container(
              child: TableCalendar(
                rowHeight: 50,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: ((day) => isSameDay(day, today)),
                focusedDay: today,
                firstDay: DateTime.utc(2022, 11, 15),
                lastDay: DateTime.utc(2030, 11, 15),
                onDaySelected: _onDaySelected,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListView.separated(
                    itemCount: subjects.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subjects[index],
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                                Text(
                                  '8:00 AM - 9:45 AM', // Remplacez par l'heure de la matière
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: subjects[index] !=
                                  'Aucune matière disponible',
                              child: Icon(
                                Icons.person_pin_circle_sharp,
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      );

                      /*  title: Row(
                          children: [
                            Visibility(
                              visible: subjects[index] !=
                                  'Aucune matière disponible',
                              child: Icon(
                                Icons.person_pin_circle_sharp,
                                size: 40.0,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subjects[index],
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                                Text(
                                  '8:00 AM - 9:45 AM', // Remplacez par l'heure de la matière
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors
                                        .grey, // Couleur du texte de l'heure
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),*/
                    },
                  )

                  /*   ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        subjects[index],
                        style: TextStyle(
                          fontSize: 28.0, // Adjust the font size as needed
                        ),
                      ),
                      trailing: Row(
                        children: [
                          Visibility(
                            visible:
                                subjects[index] != 'Aucune matière disponible',
                            child: Icon(
                              Icons.person_pin_circle_sharp,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),*/
                  ),
            ),
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.person_pin_circle_sharp,
                      color: Colors.green,
                      size: 40.0, // Ajustez la taille de l'icône au besoin
                    ),
                    onPressed: () {
                      // Action lorsque l'icône est pressée
                    },
                    iconSize: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      'Présent',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_pin_circle_sharp,
                      color: Color.fromARGB(255, 235, 38, 4),
                      size: 40.0, // Ajustez la taille de l'icône au besoin
                    ),
                    onPressed: () {
                      // Action lorsque l'icône est pressée
                    },
                    iconSize: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      'Absent',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
