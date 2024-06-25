
import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/model/fecho_model.dart';
import 'package:fechos/pages/matriculas/page/matricula_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondutorCard extends StatelessWidget {
  final FechoModel condutor;
  const CondutorCard({super.key, required this.condutor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 4, // Define a elevação desejada
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color:  Theme.of(context).cardColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 80,
                child: Text(
                  "Nº ${condutor.nomot}",
                  style: Styles.heading5n.copyWith(color: condutor.fechado==0?ColorPalette.red:Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                condutor.nomemot ??
                    '',
                style: Styles.heading5n.copyWith(color: condutor.fechado==0?ColorPalette.red:Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
      onTap: () async{
        fechoMatriculaController.putFechoMotorista(num: condutor.nomot);
        Get.to(MatriculaPage(matriculas: condutor.matriculas!, condutor: condutor.nomemot.toString(), num: condutor.nomot.toString()));
      },
    );
  }
}