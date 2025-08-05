import 'package:flutter/material.dart';
import 'package:marina/common/widgets/text_field.dart';

Widget searchBar() {
  return Row(
    children: [
      Expanded(
        // width: 300,
        child: textField(
          suffix: Icon(Icons.search_rounded),
          hint: "Pesquisar",
          func: (value) {},
        ),
      ),
    ],
  );
}
