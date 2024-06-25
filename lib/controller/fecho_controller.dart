import 'package:fechos/model/fecho_model.dart';
import 'package:fechos/service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FechoController extends GetxController {
  static FechoController instance = Get.find();

  List<FechoModel> fechosList = <FechoModel>[].obs;

  Rx<String> formattedDate = "".obs;

  final RxList<FechoModel> filteredFechosList = RxList<FechoModel>();

  final  searchTextController = TextEditingController();

  @override
  void onInit() async{
    var now =  DateTime.now();
    var formatter =  DateFormat('yyyy-MM-dd');
     formattedDate.value = formatter.format(now);
    await getFechoList(formattedDate.value,formattedDate.value);
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    //searchFieldFocusNode.dispose();
    super.onClose();
  }
  Future getFechoList(String dataF, String dataA) async {
    fechosList.clear();
    filteredFechosList.clear();
    var body = [
      {
        "dataFecho":dataF,
        "dataAbertura":dataA
      }
    ];
    var data = await ServiceData.getService("getFecho/0");

    print("fechos");
    print(data);

    if (data != null) {
      fechosList = data.map<FechoModel>((json) => FechoModel.fromJson(json)).toList();
      filteredFechosList.addAll(fechosList);
    } else {
      Get.snackbar("SolAtlantico", "Lista de fechos não encontrado");
    }

  }

  void filterFecho(String query) {
    //final query = searchTextController.text.toLowerCase();
    if (query == null) {
      // Se a pesquisa estiver vazia, exibe todos os itens
      filteredFechosList.assignAll(fechosList);
    } else {
      // Filtra os itens com base no termo de pesquisa
      filteredFechosList.assignAll(fechosList.where((item) => item.nomot!.toString().toLowerCase().contains(query)),
      );
    }
  }


  List<Dados> ordenarLista(List<Dados> lista) {
    lista.sort((a, b) => b.hfecho!.compareTo(a.hfecho!));
    return lista;
  }


}