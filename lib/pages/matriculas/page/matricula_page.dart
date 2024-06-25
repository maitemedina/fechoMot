import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/images.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/model/fecho_model.dart';
import 'package:fechos/pages/matriculas/widgets/matricula_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatriculaPage extends StatelessWidget {
  final List<Matriculas> matriculas;
  final String condutor;
  final String num;
  const MatriculaPage({super.key, required this.matriculas, required this.condutor, required this.num});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: ColorPalette.primary),
            onTap: () {
              fechoMatriculaController.totalMot.value = "";
              fechoMatriculaController.totalMat.value = "";
              Get.back();
            },
          ),
          title: Image.asset(Images.logo, width: 80),
          titleSpacing: 1,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8),
          //     child: Center(
          //         child: Text(loginController.user.first.usercode ?? '',
          //             style: Styles.textRegular
          //                 .copyWith(color: ColorPalette.primary))),
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Condutor: ",
                      style: Styles.textBold),
                  Text(condutor,
                      style: Styles.textRegular),
                ],
              ),
              const SizedBox(height: 5),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Bilhete: ",
                      style: Styles.textBold),
                  Obx(()=> Text(fechoMatriculaController.totalMot.value,
                        style: Styles.textRegular),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Data: ",
                      style: Styles.textBold),
                  Text(fechoController.formattedDate.value,
                      style: Styles.textRegular),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child:ListView.builder(
                        shrinkWrap: true,
                        itemCount: matriculas.length,
                        itemBuilder: (context, index){
                          //var list = fechoController.ordenarLista(matriculas);
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: MatriculaCard(matricula: matriculas[index], num: num,nome: condutor));
                        }),
              )
              // }),
            ],
          ),
        ));
  }
}
