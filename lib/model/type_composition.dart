class TypeComposition {
  String Id;
  String Libelle;
  String PeriodeId;

  TypeComposition({
    required this.Id,
    required this.Libelle,
    required this.PeriodeId,
  });

  static fromJson(Map json) {
    return TypeComposition(
      Id: json["id"],
      Libelle: json["libelle"],
      PeriodeId: json["periodeId"],
    );
  }

  static fromSQL(Map json) {
    return TypeComposition(
      Id: json["Id"],
      Libelle: json["Libelle"],
      PeriodeId: json["PeriodeId"],
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM TypeComposition WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM TypeComposition
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO TypeComposition(Id, Libelle, PeriodeId ) VALUES(?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table TypeComposition(
      Id Text PRIMARY KEY, Libelle TEXT, PeriodeId TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE TypeComposition SET Libelle = ?, PeriodeId = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(TypeComposition TypeComposition) {
    return {
      "Id": TypeComposition.Id,
      "Libelle": TypeComposition.Libelle,
      "PeriodeId": TypeComposition.PeriodeId,
    };
  }

  static List<Object> toSQLData(TypeComposition TypeComposition) {
    return [
      TypeComposition.Id,
      TypeComposition.Libelle,
      TypeComposition.PeriodeId.toString(),
    ];
  }

  static List<Object> toUpdateSQLData(TypeComposition TypeComposition) {
    return [
      TypeComposition.Libelle,
      TypeComposition.PeriodeId.toString(),
      TypeComposition.Id,
    ];
  }
}
