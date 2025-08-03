import 'package:flutter/material.dart';
import 'package:marina/common/widgets/text_field.dart';

Widget searchBar() {
  return Row(
    children: [
      Container(
        width: 300,
        child: textField(icon: Icons.search_rounded, label: "Pesquisar"),
      ),
    ],
  );
}
