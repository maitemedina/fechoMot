import 'package:fechos/constant/theme.dart';
import 'package:fechos/controller/fecho_controller.dart';
import 'package:fechos/controller/fecho_matricula_controller.dart';
import 'package:fechos/controller/fecho_pers_controller.dart';
import 'package:fechos/controller/login_controller.dart';
import 'package:fechos/controller/turno_controller.dart';
import 'package:fechos/pages/fecho/page/fecho_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(LoginController());
  Get.put(FechoController());
  Get.put(FechoMatriculaController());
  Get.put(FechoPersController());
  Get.put(TurnoController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sol',
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(context),
      darkTheme: getDarkTheme(context),
      home: const FechoPage(),
    );
  }
}

