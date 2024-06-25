import 'dart:convert';

import 'package:fechos/constant/controller.dart';
import 'package:fechos/model/detalhe_fecho_mat_model.dart';
import 'package:fechos/model/fecho_total_model.dart';
import 'package:fechos/pages/matriculas/page/detalhe_fecho_page.dart';
import 'package:fechos/service/service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FechoMatriculaController extends GetxController {
  static FechoMatriculaController instance = Get.find();

  List<FechoTotalModel> fechoTotalMat = <FechoTotalModel>[].obs;
  List<FechoTotalModel> fechoTotalMot = <FechoTotalModel>[].obs;
  List<DetalheFechoMatModel> detalheFechoMat = <DetalheFechoMatModel>[].obs;

  Rx<String> totalMat = "".obs;
  Rx<String> totalMot = "".obs;

  // @override
  // void onInit() async{
  //   await putFechoMatricula(num: "90",matricula: "ST-38-QZ");
  //   super.onInit();
  // }


  Future putFechoMatricula({num, matricula, date}) async {


    if(date == null || date == '') {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      date = formatter.format(now);
    }

    var body = [{
      "mot": num,
      "dataA": date,
      "dataF": date
    }
    ];

    var data = await ServiceData.putService2(body, "fechoMatricula/$matricula");

    print("fecho por matricula");
    print(data);

    if (data != null) {
      fechoTotalMat= data.map<FechoTotalModel>((json) => FechoTotalModel.fromJson(json)).toList();
      totalMat.value = fechoTotalMat.first.totalBilhete.toString();
    }
    else {
      return Get.snackbar(
          "SolAtlantico", "Erro carregando os fechos por matricula");
    }
  }

  Future putFechoMotorista({num,  dataA}) async {
    String date;

    if(dataA == null || dataA == '') {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      date = formatter.format(now);
    }else{
      date = dataA;
    }

    var body = [{
      "dataA": date,
      "dataF": date
    }
    ];

    var data = await ServiceData.putService2(body, "fechoMotorista/$num");

    print("fecho por motorista");
    print(data);

    if (data != null) {

        fechoTotalMot= data.map<FechoTotalModel>((json) => FechoTotalModel.fromJson(json)).toList();
        totalMot.value = fechoTotalMot.first.totalBilhete.toString();

    }
    else {
      return Get.snackbar(
          "SolAtlantico", "Erro carregando os fechos por motorista");
    }
    print(fechoTotalMot.first.totalBilhete);
  }


  Future putDetalheFechoMatricula({num, matricula, nome, date}) async {
    // var now = DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);

    if(date == null || date == '') {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      date = formatter.format(now);
    }


    var body = [{
      "mot": num,
      "dataA": date,
      "dataF": date
    }
    ];

    var data = await ServiceData.putService2(body, "detalheFecho/$matricula");

    print("detalhe fecho por matricula");
    print(data);

    if (data != null) {
      detalheFechoMat= data.map<DetalheFechoMatModel>((json) => DetalheFechoMatModel.fromJson(json)).toList();
      Get.to(DetalheFechoPage(condutor: nome,matricula: matricula));
    }
    else {
      return Get.snackbar(
          "SolAtlantico", "Erro carregando os detalhes fechos por matricula");
    }
  }
}