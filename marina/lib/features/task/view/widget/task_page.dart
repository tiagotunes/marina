import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/models/task.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:marina/common/widgets/text_field.dart';
import 'package:marina/features/task/provider/comment_notifier.dart';
import 'package:marina/features/task/provider/measure_notifier.dart';
import 'package:marina/features/task/provider/task_page_notifier.dart';
import 'package:marina/features/task/view/widget/measure_value_button.dart';

void _onBack(WidgetRef ref, PageController pageController) {
  final currentIndex = ref.read(indexDotProvider);
  if (currentIndex > 0) {
    final newIndex = currentIndex - 1;
    pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    ref.read(indexDotProvider.notifier).changeIndex(newIndex);
  }
}

void _onNext(WidgetRef ref, PageController pageController, int pageCount) {
  final currentIndex = ref.read(indexDotProvider);
  if (currentIndex < pageCount - 1) {
    final newIndex = currentIndex + 1;
    pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    ref.read(indexDotProvider.notifier).changeIndex(newIndex);
  }
}

void _onSubmit(WidgetRef ref) {}

Widget taskPage1(WidgetRef ref, PageController pageController, TaskModel task) {
  return taskPageBase(
    ref: ref,
    pageController: pageController,
    child: Column(
      children: [
        Text(task.docId!.title!, style: TextStyles.heading3),
        SizedBox(height: 16),
        Text(task.docId!.text!, style: TextStyles.body1),
      ],
    ),
    page: 1,
    pageCount: 3,
  );
}

Widget taskPage2(WidgetRef ref, PageController pageController, TaskModel task) {
  final selectedValues = ref.watch(
    measureNotifierProvider(task.measures ?? []),
  );

  return taskPageBase(
    ref: ref,
    pageController: pageController,
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: task.measures!.length,
      separatorBuilder: (_, __) => const SizedBox(height: 48),
      itemBuilder: (context, index) {
        final measure = task.measures![index];
        final selectedValue = selectedValues[measure.id ?? ''];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(measure.measureTypeId?.text ?? '', style: TextStyles.heading4),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) {
                final number = i + 1;
                final isSelected =
                    number == selectedValue && selectedValue != 0;
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(measureNotifierProvider(task.measures!).notifier)
                        .setValue(measure.id ?? '', number);
                  },
                  child: measureValueButton(number, isSelected),
                );
              }),
            ),
          ],
        );
      },
    ),
    page: 2,
    pageCount: 3,
  );
}

Widget taskPage3(WidgetRef ref, PageController pageController, TaskModel task) {
  final comment = ref.watch(commentNotifierProvider(task.comment ?? ""));
  final controller = TextEditingController(text: comment);

  return taskPageBase(
    ref: ref,
    pageController: pageController,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Comentário", style: TextStyles.heading4),
        const SizedBox(height: 16),
        textField(
          controller: controller,
          hint: "Escreve um comentário",
          func: (value) {
            ref.read(commentNotifierProvider(value).notifier).setComment(value);
          },
        ),
      ],
    ),
    page: 3,
    pageCount: 3,
  );
}

Widget taskPageBase({
  required WidgetRef ref,
  required PageController pageController,
  required Widget child,
  int page = 0,
  int pageCount = 0,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: Container(
      decoration: taskPageDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: child), // allow scrolling content to expand properly
          taskPageIcons(
            page,
            onNext: () => _onNext(ref, pageController, pageCount),
            onBack: () => _onBack(ref, pageController),
            onSubmit: () => _onSubmit(ref),
          ),
        ],
      ),
    ),
  );
}

Widget taskPageIcons(
  int page, {
  VoidCallback? onNext,
  VoidCallback? onBack,
  VoidCallback? onSubmit,
}) {
  switch (page) {
    case 1:
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Next',
            onPressed: onNext,
            icon: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ],
      );
    case 2:
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
          IconButton(
            tooltip: 'Next',
            onPressed: onNext,
            icon: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ],
      );
    case 3:
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
          IconButton(
            tooltip: 'Submit',
            onPressed: onSubmit,
            icon: const Icon(Icons.playlist_add_check_rounded),
          ),
        ],
      );
    default:
      return const SizedBox.shrink();
  }
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
