import '../managers/type_composition_manager.dart';
import '../model/type_composition.dart';
import '../services/api/type_composition_service.dart';
import '../services/connection_service.dart';

class TypeCompositionData {
  TypeCompositionManager typeCompositionManager = TypeCompositionManager();
  TypeCompositionApiService typeCompositionApiService =
      TypeCompositionApiService();

  Future<List<TypeComposition>?> getData() async {
    if (await ConnectionService.isConnected()) {
      var data = await typeCompositionApiService.getData();
      updateTypeComposition(data);
      return data;
    } else {
      return await typeCompositionManager.getData();
    }
  }

  Future<void> updateTypeComposition(List<TypeComposition>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await typeCompositionManager.updateData(element);
      });
    }
  }
}
