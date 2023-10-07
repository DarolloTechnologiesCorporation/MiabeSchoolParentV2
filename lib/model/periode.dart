class Periode {
  String Id;
  String Libelle;
  DateTime Datedebut;
  DateTime Datefin;

  Periode({
    required this.Id,
    required this.Libelle,
    required this.Datedebut,
    required this.Datefin,
  });

  static fromJson(Map json) {
    return Periode(
        Id: json["Id"],
        Libelle: json["Libelle"],
        Datedebut: DateTime.parse(json["Datedebut"]),
        Datefin: DateTime.parse(json["Datefin"]));
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
    INSERT INTO Periode(Id, Libelle, Datedebut, Datefin) VALUES(?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Periode(
      Id Text PRIMARY KEY, Libelle TEXT, Datedebut TEXT, Datefin TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Periode SET Libelle = ?, Datedebut = ?, Datefin = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Periode periode) {
    return {
      "Id": periode.Id,
      "Libelle": periode.Libelle,
      "Datedebut": periode.Datedebut,
      "Datefin": periode.Datefin,
    };
  }

  static List<Object> toSQLData(Periode periode) {
    return [
      periode.Id,
      periode.Libelle,
      periode.Datedebut.toString(),
      periode.Datefin.toString(),
    ];
  }
}
