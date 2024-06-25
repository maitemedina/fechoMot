import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/style.dart';
import 'package:fechos/model/fecho_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatriculaCard extends StatefulWidget {
  final Matriculas matricula;
  final String num;
  final String nome;

  final String? date;
  const MatriculaCard({super.key, required this.matricula, required this.num, required this.nome, this.date});

  @override
  State<MatriculaCard> createState() => _MatriculaCardState();
}

class _MatriculaCardState extends State<MatriculaCard> {
  // @override
  // void initState() {
  //   super.initState();
  //    fechoMatriculaController.putFechoMatricula(num: widget.num, matricula: widget.matricula.matricula);
  // }


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
              color:  widget.matricula.fechado==0?Theme.of(context).errorColor: Theme.of(context).cardColor),
          child: ExpansionTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.matricula.matricula.toString(), style: Styles.lead),

                GestureDetector(child: Icon(Icons.remove_red_eye), onTap: ()async{
                  fechoMatriculaController.putDetalheFechoMatricula(matricula: widget.matricula.matricula.toString(), num: widget.num, nome: widget.nome, date: widget.date);
                  fechoMatriculaController.putFechoMatricula(num: widget.num,matricula: widget.matricula.matricula.toString(), date: widget.date);
                },),
              ],
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.matricula.dados!.length,
                itemBuilder: (context, dataIndex) {
                  //final dado = widget.matricula.dados![dataIndex];
                  var list = fechoController.ordenarLista(widget.matricula.dados!);
                  return ListTile(
                    title: Text('ID do Terminal: ${list[dataIndex].idterminal}', style: Styles.textBold),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Abertura: ${list[dataIndex].dabertura} ás ${list[dataIndex].habertura}', style: Styles.textRegular),
                        list[dataIndex].dfecho=='1900-01-01'?Text('Ainda não fez fecho!!',style: Styles.textRegular):Text('Fecho: ${list[dataIndex].dfecho} ás ${list[dataIndex].hfecho}', style: Styles.textRegular),

                      ],
                    ),
                  );
                },
              ),
            ],
          )
        ),
      ),
      onTap: () async{
      },
    );
  }
}
