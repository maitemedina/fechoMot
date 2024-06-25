import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/model/fecho_model.dart';
import 'package:fechos/model/tuno_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnoCard extends StatefulWidget {
  final TurnoModel turno;
  const TurnoCard({super.key, required this.turno});

  @override
  State<TurnoCard> createState() => _MatriculaCardState();
}

class _MatriculaCardState extends State<TurnoCard> {


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
            child: ListTile(
              title: Text('Matricula: ${widget.turno.div}', style: Styles.textBold),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Linha: ${widget.turno.uLinha}'),
                  Text('Data: ${widget.turno.dATA}'),
                  Text('Hora Abertura: ${widget.turno.hinicio} ás ${widget.turno.hfim}', style: Styles.textRegular),
                ],
              ),
            )
        ),
      ),
      onTap: () async{
      },
    );
  }
}
