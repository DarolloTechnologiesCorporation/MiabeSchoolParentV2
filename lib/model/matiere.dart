class Matiere {
  String Id;
  String Libelle;
  String CodeMatiere;

  Matiere({
    required this.Id,
    required this.Libelle,
    required this.CodeMatiere,
  });

  static fromJson(Map json) {
    return Matiere(
      Id: json["id"],
      Libelle: json["libelle"],
      CodeMatiere: json["codeMatiere"],
    );
  }

  static fromSQL(Map json) {
    return Matiere(
      Id: json["Id"],
      Libelle: json["Libelle"],
      CodeMatiere: json["CodeMatiere"],
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM Matiere WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM Matiere
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO Matiere(Id, Libelle, CodeMatiere) VALUES(?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Matiere(
      Id Text PRIMARY KEY, Libelle TEXT, CodeMatiere TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Matiere SET Libelle = ?, CodeMatiere = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Matiere Matiere) {
    return {
      "Id": Matiere.Id,
      "Libelle": Matiere.Libelle,
      "CodeMatiere": Matiere.CodeMatiere,
    };
  }

  static List<Object> toSQLData(Matiere Matiere) {
    return [
      Matiere.Id,
      Matiere.Libelle,
      Matiere.CodeMatiere.toString(),
    ];
  }

  static List<Object> toUpdateSQLData(Matiere Matiere) {
    return [
      Matiere.Libelle,
      Matiere.CodeMatiere.toString(),
      Matiere.Id,
    ];
  }
}
