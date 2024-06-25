import 'package:fechos/constant/controller.dart';
import 'package:fechos/model/fecho_model.dart';
import 'package:fechos/model/motorista_model.dart';
import 'package:fechos/service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tuple/tuple.dart';

class FechoPersController extends GetxController {
  static FechoPersController instance = Get.find();

  Rx<String?> selectedDate = "".obs;
  Rx<String?> selectedDateEnd = ''.obs;
  Rx<String?> selectedMot = ''.obs;

  void onDateSelected(String? date) {
    selectedDate.value = date;
  }
  void onDateSelectedEnd(String? date) {
    selectedDateEnd.value = date;
  }
  List<FechoModel> fechoMotList = <FechoModel>[].obs;
  List<MotoristaModel> motoristaList = <MotoristaModel>[].obs;
  final items = <Tuple2<String, String>>[].obs;
  @override


  Future getMotoristaList() async {
    var data = await ServiceData.getService("getMotorista");

    print("motorista");
    print(data);

    if (data != null) {
      motoristaList = data.map<MotoristaModel>((json) => MotoristaModel.fromJson(json)).toList();

      final itemsList = motoristaList.map<Tuple2<String, String>>((item) {
        return Tuple2(item.cmdesc??'', item.cm??'');
      }).toList();

      // Add the default option as the first item
      itemsList.insert(0, Tuple2('-- Seleciona um Condutor --', ''));

      items.assignAll(itemsList);

    } else {
      Get.snackbar("SolAtlantico", "Lista de motorista não encontrado");
    }

  }

  Future putFechoMotList(String dataA, String nmot) async {
    fechoMotList.clear();
    var body = [
      {
        "dataA":dataA,
        "nmot":nmot,
      }
    ];
    var data = await ServiceData.putService2(body,"getFechoMot");

    print("fechoMot");
    print(data);

    if (data != null) {
      fechoMotList = data.map<FechoModel>((json) => FechoModel.fromJson(json)).toList();
      fechoMatriculaController.putFechoMotorista(num: fechoMotList.first.nomot, dataA: dataA);
    } else {
      Get.snackbar("SolAtlantico", "Lista de fechos de motorista não encontrado");
    }
    update();
  }

  Future getFechoList(String dataF, String dataA) async {
    fechoMotList.clear();
    var body = [
      {
        "dataFecho":dataF,
        "dataAbertura":dataA
      }
    ];
    var data = await ServiceData.getService("getFecho/$dataA");

    print("fechos");
    print(data);

    if (data != null) {
      fechoMotList = data.map<FechoModel>((json) => FechoModel.fromJson(json)).toList();
    } else {
      Get.snackbar("SolAtlantico", "Lista de fechos não encontrado");
    }
    update();
  }
}