import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/images.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/pages/fecho/page/fecho_pers_page.dart';
import 'package:fechos/pages/fecho/page/turno_page.dart';
import 'package:fechos/pages/fecho/widgets/condutor_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FechoPage extends StatelessWidget {
  const FechoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          // leading: GestureDetector(
          //   child: Icon(Icons.arrow_back, color: ColorPalette.primary),
          //   onTap: () {
          //   },
          // ),
          title: Image.asset(Images.logo, width: 80),
          titleSpacing: 1,
          actions:  [
            GestureDetector(
              child: Padding(
                  padding: const EdgeInsets.only( left: 50),
                  child: Icon(Icons.directions_bus_sharp, size: 30, color: ColorPalette.primary)
                // Center(
                //     child: Text(loginController.user.first.usercode ?? '',
                //         style: Styles.textRegular
                //             .copyWith(color: ColorPalette.primary))),
              ),onTap: ()async{
              await fechoPersController.getMotoristaList();
              Get.to(TurnoPage());
            },
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 15),
                child: Icon(Icons.calendar_month, size: 30, color: ColorPalette.primary)
                // Center(
                //     child: Text(loginController.user.first.usercode ?? '',
                //         style: Styles.textRegular
                //             .copyWith(color: ColorPalette.primary))),
              ),onTap: ()async{
                await fechoPersController.getMotoristaList();
                Get.to(FechoPersPage());
            },
            ),
            GestureDetector(
              child: Padding(
                  padding: const EdgeInsets.only(right: 12, left: 15),
                  child: Icon(Icons.playlist_add_check_rounded, size: 30, color: ColorPalette.primary)
              ),onTap: ()async{
              await fechoPersController.getMotoristaList();
              Get.to(FechoPersPage());
            },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: RefreshIndicator(
            onRefresh: () async{
              await fechoController.getFechoList(fechoController.formattedDate.value,fechoController.formattedDate.value); },
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data: ${fechoController.formattedDate.value}",
                        style: Styles.heading5.copyWith(color: ColorPalette.primary)),
                  ],
                ),
                const SizedBox(height: 8),
                // CustomTextFieldSearch(initialValue: Strings.searchHereLabel, textController: matriculaController.searchTextController),
                // const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    fechoController.filterFecho(value);
                  },
                  controller: fechoController.searchTextController,
                  decoration:  InputDecoration(
                      labelText: "Pesquisar pelo nº Motorista",
                      hintText: "Pesquisar pelo nº Motorista...",
                      prefixIcon: Icon(Icons.search, color: ColorPalette.primary),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: ColorPalette.primary)),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: ColorPalette.secundary))
                  ),
                ),
                const SizedBox(height: 5),
                // GetBuilder<MatriculaController>(builder: (controller) {
                //  return controller.veiculosList.isEmpty
                //     ? const Center(child: CustomCircularProgress())
                Expanded(
                  child: Obx(()=>
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: fechoController.filteredFechosList.length,
                          itemBuilder: (context, index){
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CondutorCard(condutor: fechoController.filteredFechosList[index],));
                   }),
                  ),
                )
                // }),
              ],
            ),
          ),
        ));
  }
}
