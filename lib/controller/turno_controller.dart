import 'package:fechos/model/tuno_model.dart';
import 'package:fechos/service/service.dart';
import 'package:get/get.dart';

class TurnoController extends GetxController {
  static TurnoController instance = Get.find();


  Rx<String?> selectedMot = ''.obs;
  List<TurnoModel> turnoMotList = <TurnoModel>[].obs;

  Future putTurnoMotList( String nmot) async {
    turnoMotList.clear();
    var body = [
      {
        "nmot":nmot,
      }
    ];
    var data = await ServiceData.putService2(body,"getTurnoMot");

    print("turnoMot");
    print(data);

    if (data != null) {
      turnoMotList = data.map<TurnoModel>((json) => TurnoModel.fromJson(json)).toList();
    } else {
      Get.snackbar("SolAtlantico", "Lista de turno de motorista não encontrado");
    }
    update();
  }
}