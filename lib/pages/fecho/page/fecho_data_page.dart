import 'package:fechos/controller/fecho_pers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FechoDataPage extends StatelessWidget {
  const FechoDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: GetBuilder<FechoPersController>(
    builder: (controller) {
    return Column();}))
    );
  }
}
