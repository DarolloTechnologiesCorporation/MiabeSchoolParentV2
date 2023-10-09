class Notification {
  String Id;
  String Libelle;
  String Descritpion;
  DateTime DateNotification;
  int IsView;

  Notification(
      {required this.Id,
      required this.Libelle,
      required this.Descritpion,
      required this.DateNotification,
      required this.IsView});

  static fromJson(Map json) {
    return Notification(
        Id: json["Id"],
        Libelle: json["Libelle"],
        Descritpion: json["Descritpion"],
        DateNotification: json["DateNotification"],
        IsView: json["IsView"] as int);
  }

  static String getDeleteDefinition() {
    return """
   DELETE FROM Notification WHERE id = ?
""";
  }

  static String getSelectDefinition() {
    return """
   SELECT * FROM Notification
""";
  }

  static String getInsertDefinition() {
    return """
    INSERT INTO Notification(Id, Libelle, Descritpion, DateNotification, IsView) VALUES(?, ?, ?, ?, ?)
""";
  }

  static String getTableDefinition() {
    return """Create table Notification(
      Id Text PRIMARY KEY, Libelle TEXT, Descritpion TEXT, DateNotification TEXT, IsView Integer
    )""";
  }

  static String getUpdateDefinition() {
    return """
      UPDATE Notification SET Libelle = ?, Descritpion = ?, DateNotification = ?, IsView = ? WHERE id = ?
""";
  }

  static Map<String, dynamic> toJson(Notification Notification) {
    return {
      "Id": Notification.Id,
      "Libelle": Notification.Libelle,
      "Descritpion": Notification.Descritpion,
      "DateNotification": Notification.DateNotification,
      "IsView": Notification.IsView,
    };
  }

  static List<Object> toSQLData(Notification Notification) {
    return [
      Notification.Id,
      Notification.Libelle,
      Notification.Descritpion.toString(),
      Notification.DateNotification,
      Notification.IsView
    ];
  }
}
