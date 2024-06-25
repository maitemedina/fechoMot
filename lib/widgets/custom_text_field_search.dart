import 'package:fechos/constant/color.dart';
import 'package:fechos/constant/controller.dart';
import 'package:fechos/constant/strings.dart';
import 'package:fechos/constant/style.dart';
import 'package:flutter/material.dart';

class CustomTextFieldSearch extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? textController;
  final bool enable;

  const CustomTextFieldSearch(
      {Key? key,
        this.textController,
        this.enable = true, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      //initialValue: initialValue,
      decoration: InputDecoration(prefixIcon: Icon(Icons.search, color: ColorPalette.primary),
        border: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Theme.of(context).primaryColorDark,
        hintText: null == initialValue ? Strings.defaultHintLabel : initialValue!,
        hintStyle: Styles.textRegular,
      ),onChanged: (value){
        fechoController.filterFecho(value);
    },
      controller: textController,
    );
  }
}