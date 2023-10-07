import 'package:quiz_prokit/managers/composition_manager.dart';
import 'package:quiz_prokit/model/composition.dart';
import 'package:quiz_prokit/services/api/composition_service.dart';
import '../services/connection_service.dart';

class CompositionData {
  CompositionManager compositionManager = CompositionManager();
  CompositionApiService compositionApiService = CompositionApiService();

  Future<List<Composition>?> getData() async {
    if (await ConnectionService.isConnected()) {
      var data = await compositionApiService.getData();
      updateComposition(data);
      return data;
    } else {
      return await compositionManager.getData();
    }
  }

  Future<void> updateComposition(List<Composition>? data) async {
    if (data != null) {
      data.forEach((element) async {
        await compositionManager.updateData(element);
      });
    }
  }
}
