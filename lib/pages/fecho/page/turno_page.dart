import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/images.dart';
import 'package:fechos/constant/strings.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/controller/turno_controller.dart';
import 'package:fechos/pages/matriculas/widgets/turno_card.dart';
import 'package:fechos/widgets/button_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class TurnoPage extends StatelessWidget {
  const TurnoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: ColorPalette.primary),
            onTap: () {
              Get.back();
              turnoController.turnoMotList.clear();
            },
          ),
          title: Image.asset(Images.logo, width: 80),
          titleSpacing: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GetBuilder<TurnoController>(
              builder: (controller) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        final selectedValue = fechoPersController.items.isNotEmpty
                            ? fechoPersController.items[0]
                            : const Tuple2("", "");

                        return DropdownButtonFormField<Tuple2<String, String>>(
                          decoration:  InputDecoration(
                            enabledBorder: OutlineInputBorder( //<-- SEE HERE
                              borderSide: BorderSide(color: ColorPalette.primary, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder( //<-- SEE HERE
                              borderSide: BorderSide(color: ColorPalette.primary, width: 1),
                            ),
                          ),
                          iconEnabledColor: ColorPalette.primary,
                          value: selectedValue,
                          items: fechoPersController.items.map((item) {
                            return DropdownMenuItem<Tuple2<String, String>>(
                              value: item,
                              child: Text(item.item1),
                            );
                          }).toList(),
                          onChanged: (Tuple2<String, String>? newValue) {
                            controller.selectedMot.value = newValue?.item2;
                          },
                        );
                      }),
                      const SizedBox(height: 30),
                      Expanded(
                        child: controller.turnoMotList.isNotEmpty
                            ?ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.turnoMotList?.length,
                            itemBuilder: (context, index){
                              //var list = fechoController.ordenarLista(matriculas);
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TurnoCard(turno: controller.turnoMotList[index]));
                            })
                            : Center(
                          child: Column(
                            children: [
                              Text("Sem Dados",style: Styles.lead),
                              const SizedBox(height: 50),
                              SvgPicture.asset(
                                Images.empty_svg3, // substitua 'seu_arquivo.svg' pelo caminho do seu arquivo SVG
                                width: 200, // largura desejada da imagem
                                height: 200, // altura desejada da imagem
                              ),
                              //Image.asset(Images.empty, width: 550),
                            ],
                          ),
                        ),


                      )
                      // }),

                    ]);
              }
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ButtonUI(label: Strings.searchLabel, action: () async{
            turnoController.turnoMotList.clear();
            if(turnoController.selectedMot.value!.isNotEmpty) {
              await turnoController.putTurnoMotList(turnoController.selectedMot.value!);
            }else{
              Get.snackbar("SolAtlantico", "Tem que preencher todos os campos");
            }
          },forceExtended: true, ),
        ));
  }
}
