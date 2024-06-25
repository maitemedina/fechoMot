
import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/images.dart';
import 'package:fechos/constant/strings.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/controller/fecho_pers_controller.dart';
import 'package:fechos/pages/matriculas/widgets/matricula_card.dart';
import 'package:fechos/widgets/button_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class FechoPersPage extends StatelessWidget {
  const FechoPersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.main,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: ColorPalette.primary),
          onTap: () {
            Get.back();
            fechoPersController.selectedDate.value = '';
            fechoPersController.selectedDateEnd.value = '';
            fechoPersController.fechoMotList.clear();
          },
        ),
        title: Image.asset(Images.logo, width: 80),
        titleSpacing: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: GetBuilder<FechoPersController>(
            builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                        ()=> TextField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: controller.selectedDate.value != null
                            ? controller.selectedDate.value!.toString().split(' ')[0]
                            : 'Selecione uma data',
                      ),
                      decoration: InputDecoration(
                          labelText: "Data ",
                          hintText: "Data ...",
                          prefixIcon: Icon(Icons.calendar_month, color: ColorPalette.primary),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: ColorPalette.primary)),
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: ColorPalette.secundary))
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value!.isNotEmpty ? DateTime.parse(controller.selectedDate.value.toString()) : DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now(),
                        ).then((newDate) {
                          if (newDate != null) {
                            // Atualize a data selecionada
                            String formattedDate = "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
                            controller.onDateSelected(formattedDate);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final selectedValue = controller.items.isNotEmpty
                        ? controller.items[0]
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
                      items: controller.items.map((item) {
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
                  controller.fechoMotList.isNotEmpty
                      ? Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Condutor: ",
                                style: Styles.textBold),
                            Text(controller.fechoMotList.first.nomemot!,
                                style: Styles.textRegular),
                          ],)
                      :const SizedBox(),
                  controller.fechoMotList.isNotEmpty
                      ? Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nº: ",
                                style: Styles.textBold),
                            Text(controller.fechoMotList.first.nomot!.toString(),
                                style: Styles.textRegular),
                          ],)
                      :const SizedBox(),
                  controller.fechoMotList.isNotEmpty
                      ?Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Total Bilhete: ",
                                style: Styles.textBold),
                            Obx(()=> Text(fechoMatriculaController.totalMot.value,
                                style: Styles.textRegular),
                            ),
                          ],)
                      :const SizedBox(),
                  const SizedBox(height: 18),
                  Expanded(
                child: controller.fechoMotList.isNotEmpty
                    ?ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.fechoMotList.first.matriculas?.length,
                              itemBuilder: (context, index){
                                //var list = fechoController.ordenarLista(matriculas);
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: MatriculaCard(matricula: controller.fechoMotList.first.matriculas![index], num: controller.fechoMotList.first.nomot.toString(),nome: controller.fechoMotList.first.nomemot!, date: fechoPersController.selectedDate.value!));
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
        fechoPersController.fechoMotList.clear();
        fechoMatriculaController.totalMot.value='';
        if( fechoPersController.selectedDate.value!.isNotEmpty  || fechoPersController.selectedMot.value!.isNotEmpty) {
          await fechoPersController.putFechoMotList(fechoPersController.selectedDate.value!, fechoPersController.selectedMot.value!);
        }else{
          Get.snackbar("SolAtlantico", "Tem que preencher todos os campos");
        }
      },forceExtended: true, ),
    ));
  }
}
