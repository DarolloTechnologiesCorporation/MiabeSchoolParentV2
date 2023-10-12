class NotificationModel {
  String Id;
  String Libelle;
  String Descritpion;
  DateTime DateNotification;
  int IsView;

  NotificationModel(
      {required this.Id,
      required this.Libelle,
      required this.Descritpion,
      required this.DateNotification,
      required this.IsView});

  static fromJson(Map json) {
    return NotificationModel(
        Id: json["Id"],
        Libelle: json["Libelle"],
        Descritpion: json["Descritpion"],
        DateNotification: json["DateNotification"],
        IsView: json["IsView"] as int);
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM NotificationModel WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM NotificationModel
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO NotificationModel(Id, Libelle, Descritpion, DateNotification, IsView) VALUES(?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table NotificationModel(
      Id Text PRIMARY KEY, Libelle TEXT, Descritpion TEXT, DateNotification TEXT, IsView Integer
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE NotificationModel SET Libelle = ?, Descritpion = ?, DateNotification = ?, IsView = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(NotificationModel NotificationModel) {
    return {
      "Id": NotificationModel.Id,
      "Libelle": NotificationModel.Libelle,
      "Descritpion": NotificationModel.Descritpion,
      "DateNotification": NotificationModel.DateNotification,
      "IsView": NotificationModel.IsView,
    };
  }

  static List<Object> toSQLData(NotificationModel NotificationModel) {
    return [
      NotificationModel.Id,
      NotificationModel.Libelle,
      NotificationModel.Descritpion.toString(),
      NotificationModel.DateNotification,
      NotificationModel.IsView
    ];
  }
}
