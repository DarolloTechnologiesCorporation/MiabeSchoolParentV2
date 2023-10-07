import 'package:uuid/uuid.dart';

class BaseModel {
  late Uuid id;

  String getTableDefinition() {
    return "";
  }

  String getInsertDefinition() {
    return "";
  }

  List<Object>? toSQLData() {
    return null;
  }

  String getUpdateDefinition() {
    return "";
  }

  String getDeleteDefinition() {
    return "";
  }

  Map<String, dynamic>? toJson() {
    return null;
  }

  fromJson(Map json) {
    return "";
  }
}
