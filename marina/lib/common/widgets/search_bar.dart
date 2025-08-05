import 'package:flutter/material.dart';
import 'package:marina/common/widgets/text_field.dart';

Widget searchBar({VoidCallback? func}) {
  return Row(
    children: [
      Expanded(
        child: textField(
          suffix: Icon(Icons.search_rounded),
          hint: "Pesquisar",
          func: (value) {},
        ),
      ),
      SizedBox(width: 16),
      IconButton(onPressed: func ?? () {}, icon: Icon(Icons.tune_rounded)),
      //
    ],
  );
}
