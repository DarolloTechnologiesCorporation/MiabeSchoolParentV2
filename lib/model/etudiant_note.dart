class EtudiantNote {
  late int Id;
  String Matieres;
  String Notes;
  String TypeCompositions;
  String EtudiantId;
  String PeriodId;

  EtudiantNote(
      {required this.EtudiantId,
      required this.Matieres,
      required this.Notes,
      required this.PeriodId,
      required this.TypeCompositions});

  static fromJson(Map json) {
    return EtudiantNote(
        EtudiantId: json["etudiantId"],
        PeriodId: json["periodId"],
        Matieres: json["matieres"],
        Notes: json["notes"],
        TypeCompositions: json["typeCompositions"]);
  }

  static fromSQL(Map json) {
    return EtudiantNote(
        EtudiantId: json["EtudiantId"].toString(),
        PeriodId: json["PeriodId"].toString(),
        Matieres: json["Matieres"].toString(),
        Notes: json["Notes"].toString(),
        TypeCompositions: json["TypeCompositions"].toString());
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM EtudiantNote WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM EtudiantNote
""";
  }

  static String getTableDefinition() {
    return """Create table EtudiantNote(
      Id INTEGER PRIMARY KEY AUTOINCREMENT, Matieres TEXT, Notes TEXT, TypeCompositions TEXT, PeriodId TEXT, EtudiantId TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE EtudiantNote SET Matiere = ?, Note = ?, TypeCompositions = ?,  ,  WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(EtudiantNote EtudiantNote) {
    return {
      "Id": EtudiantNote.Id,
      "Matieres": EtudiantNote.Matieres,
      "Notes": EtudiantNote.Notes,
      "PeriodId": EtudiantNote.PeriodId,
      "EtudiantId": EtudiantNote.EtudiantId,
      "TypeCompositions": EtudiantNote.TypeCompositions,
    };
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO EtudiantNote(Id, Matiere, Note, TypeCompositions, EtudiantId, PeriodId) VALUES(?, ?, ?, ?, ?, ?)
""";
  }

  static List<Object> toSQLData(EtudiantNote EtudiantNote) {
    return [
      EtudiantNote.Id,
      EtudiantNote.Matieres,
      EtudiantNote.Notes.toString(),
      EtudiantNote.TypeCompositions,
      EtudiantNote.EtudiantId,
      EtudiantNote.PeriodId
    ];
  }

  static List<Object> toUpdateSQLData(EtudiantNote EtudiantNote) {
    return [
      EtudiantNote.Matieres,
      EtudiantNote.Notes.toString(),
      EtudiantNote.TypeCompositions,
      EtudiantNote.EtudiantId,
      EtudiantNote.PeriodId,
      EtudiantNote.Id
    ];
  }
}
