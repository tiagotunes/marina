import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/models/measure.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/task/provider/comment_notifier.dart';
import 'package:marina/features/task/provider/measure_notifier.dart';

Widget taskPage1(String title, String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: taskPageDecoration(),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title, style: TextStyles.heading3),
          SizedBox(height: 16),
          Text(text, style: TextStyles.body1),
        ],
      ),
    ),
  );
}

Widget taskPage2(WidgetRef ref, List<Measure> measures) {
  final selectedValues = ref.watch(measureNotifierProvider(measures));

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: taskPageDecoration(),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: measures.map((measure) {
          final selectedValue = selectedValues[measure.id ?? ''];

          return Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  measure.measureTypeId?.text ?? '',
                  style: TextStyles.heading4,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    final number = index + 1;
                    final isSelected =
                        number == selectedValue && selectedValue != 0;
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(measureNotifierProvider(measures).notifier)
                            .setValue(measure.id ?? '', number);
                      },
                      child: numberButton(number, isSelected),
                    );
                  }),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget taskPage3(WidgetRef ref, String oldComment) {
  final comment = ref.watch(commentNotifierProvider(oldComment));
  final controller = TextEditingController(text: comment);
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: taskPageDecoration(),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textField(
            controller: controller,
            prefix: Icon(Icons.edit_rounded),
            label: "Comentário",
            func: (value) {
              ref
                  .read(commentNotifierProvider(value).notifier)
                  .setComment(value);
            },
          ),
        ],
      ),
    ),
  );
}

Widget numberButton(int number, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: isSelected
          ? Colours.lightThemePrimaryColour
          : Colours.lightThemeGray2Colour,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        number.toString(),
        style: isSelected
            ? TextStyles.button.copyWith(color: Colours.lightThemeWhiteColour)
            : TextStyles.button,
      ),
    ),
  );
}

BoxDecoration taskPageDecoration() {
  return BoxDecoration(
    color: Colours.lightThemeGray1Colour,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colours.lightThemeBlackColour.withValues(alpha: 0.25),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );
}
