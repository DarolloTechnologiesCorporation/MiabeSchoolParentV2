class Periode {
  String Id;
  String Libelle;
  String AnneAcademique;
  String EtudiantId;
  DateTime Datedebut;
  DateTime Datefin;

  Periode({
    required this.Id,
    required this.EtudiantId,
    required this.Libelle,
    required this.AnneAcademique,
    required this.Datedebut,
    required this.Datefin,
  });

  static fromJson(Map json) {
    return Periode(
        Id: json["id"],
        Libelle: json["libelle"],
        AnneAcademique: json["anneAcademique"],
        EtudiantId: json["etudiantId"],
        Datedebut: DateTime.parse(json["dateDebut"]),
        Datefin: DateTime.parse(json["dateFin"]));
  }

  static fromSQL(Map json) {
    return Periode(
        Id: json["Id"].toString(),
        Libelle: json["Libelle"].toString(),
        AnneAcademique: json["AnneAcademique"].toString(),
        EtudiantId: json["EtudiantId"].toString(),
        Datedebut: DateTime.parse(json["Datedebut"].toString()),
        Datefin: DateTime.parse(json["Datefin"].toString()));
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM Periode WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM Periode
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO Periode(Id, Libelle, Datedebut, Datefin, EtudiantId,AnneAcademique) VALUES(?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Periode(
      Id Text PRIMARY KEY, Libelle TEXT, Datedebut TEXT, Datefin TEXT, EtudiantId TEXT, AnneAcademique TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Periode SET Libelle = ?, Datedebut = ?, Datefin = ?, EtudiantId = ?, AnneAcademique = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Periode periode) {
    return {
      "Id": periode.Id,
      "Libelle": periode.Libelle,
      "AnneAcademique": periode.AnneAcademique,
      "Datedebut": periode.Datedebut,
      "Datefin": periode.Datefin,
      "EtudiantId": periode.EtudiantId,
    };
  }

  static List<Object> toSQLData(Periode periode) {
    return [
      periode.Id,
      periode.Libelle,
      periode.AnneAcademique,
      periode.Datedebut.toString(),
      periode.Datefin.toString(),
      periode.EtudiantId,
    ];
  }

  static List<Object> toUpdateSQLData(Periode periode) {
    return [
      periode.Libelle,
      periode.Datedebut.toString(),
      periode.Datefin.toString(),
      periode.EtudiantId,
      periode.AnneAcademique,
      periode.Id,
    ];
  }
}
