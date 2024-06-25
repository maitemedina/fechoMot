import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/images.dart';
import 'package:fechos/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalheFechoPage extends StatelessWidget {
  final String condutor;
  final String matricula;
  const DetalheFechoPage({super.key, required this.condutor, required this.matricula});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: ColorPalette.primary),
            onTap: () {
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
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Condutor: ",
                          style: Styles.textBold),
                      Text(condutor,
                          style: Styles.textRegular),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matricula: ",
                          style: Styles.textBold),
                      Text(matricula,
                          style: Styles.textRegular),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Obx(()=> Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bilhete: ",
                          style: Styles.textBold),
                      Text(fechoMatriculaController.totalMat.value, style: Styles.textRegular),
                    ],
                  )),
                ),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('ID Terminal'),
                    ),
                    DataColumn(
                      label: Text('Hora do Evento'),
                    ),
                    DataColumn(
                      label: Text('Tipo de Evento'),
                    ),
                    // DataColumn(
                    //   label: Text('Número do Cartão'),
                    // ),
                    DataColumn(
                      label: Text('Linha'),
                    ),
                    DataColumn(
                      label: Text('Localização'),
                    ),
                    DataColumn(
                      label: Text('Número de Viagens'),
                    ),
                  ],
                  rows: fechoMatriculaController.detalheFechoMat.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(data.idterminal.toString())),
                        DataCell(Text(data.hevento.toString())),
                        DataCell(Text(data.tipoevento.toString())),
                        //DataCell(Text(data.nocartao.toString())),
                        DataCell(Text(data.linha.toString())),
                        DataCell(Text(data.localizacao.toString())),
                        DataCell(Text(data.noviagem.toString())),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
