class Composition {
  String Id;
  String Matiere;
  String Note;
  String TypeComposition;

  Composition({
    required this.Id,
    required this.Matiere,
    required this.Note,
    required this.TypeComposition,
  });

  static fromJson(Map json) {
    return Composition(
        Id: json["Id"],
        Matiere: json["Matiere"],
        Note: json["Note"],
        TypeComposition: json["TypeComposition"]);
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM Composition WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM Composition
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO Composition(Id, Matiere, Note, TypeComposition) VALUES(?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Composition(
      Id Text PRIMARY KEY, Matiere TEXT, Note TEXT, TypeComposition TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Composition SET Matiere = ?, Note = ?, TypeComposition = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Composition Composition) {
    return {
      "Id": Composition.Id,
      "Matiere": Composition.Matiere,
      "Note": Composition.Note,
      "TypeComposition": Composition.TypeComposition,
    };
  }

  static List<Object> toSQLData(Composition Composition) {
    return [
      Composition.Id,
      Composition.Matiere,
      Composition.Note.toString(),
      Composition.TypeComposition.toString(),
    ];
  }
}
