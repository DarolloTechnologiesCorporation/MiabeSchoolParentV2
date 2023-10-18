class FailedPaiementModel {
  int Id;
  String PaiementNumber;
  String PaiementPrice;
  String PaiementFraisId;
  String PaiementEtudiantId;
  String PaiementReference;

  FailedPaiementModel(
      {required this.Id,
      required this.PaiementEtudiantId,
      required this.PaiementFraisId,
      required this.PaiementNumber,
      required this.PaiementReference,
      required this.PaiementPrice});

  static fromSQL(Map json) {
    return FailedPaiementModel(
      Id: int.parse(json["EtudiantId"].toString()),
      PaiementEtudiantId: json["PaiementEtudiantId"].toString(),
      PaiementFraisId: json["PaiementFraisId"].toString(),
      PaiementReference: json["PaiementReference"].toString(),
      PaiementNumber: json["PaiementNumber"].toString(),
      PaiementPrice: json["PaiementPrice"].toString(),
    );
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM FailedPaiementModel WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM FailedPaiementModel
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO FailedPaiementModel(Id, PaiementEtudiantId, PaiementFraisId, PaiementNumber, PaiementPrice,PaiementReference) VALUES(?, ?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table FailedPaiementModel(
      Id INTEGER PRIMARY KEY AUTOINCREMENT, PaiementEtudiantId TEXT, PaiementFraisId TEXT, PaiementNumber TEXT, PaiementPrice TEXT, PaiementReference TEXT
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE FailedPaiementModel SET PaiementEtudiantId = ?, PaiementFraisId = ?, PaiementNumber = ?, PaiementPrice = ?, PaiementReference = ? WHERE id = ?
""";
  }

  static List<Object> toSQLData(FailedPaiementModel failedPaiementModel) {
    return [
      // failedPaiementModel.Id,
      failedPaiementModel.PaiementEtudiantId,
      failedPaiementModel.PaiementFraisId,
      failedPaiementModel.PaiementNumber,
      failedPaiementModel.PaiementPrice,
      failedPaiementModel.PaiementReference,
    ];
  }

  static List<Object> toUpdateSQLData(FailedPaiementModel failedPaiementModel) {
    return [
      failedPaiementModel.PaiementEtudiantId,
      failedPaiementModel.PaiementFraisId,
      failedPaiementModel.PaiementNumber,
      failedPaiementModel.PaiementPrice,
      failedPaiementModel.PaiementReference,
      failedPaiementModel.Id,
    ];
  }
}
