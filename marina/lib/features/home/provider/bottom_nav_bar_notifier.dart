import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_bar_notifier.g.dart';

@riverpod
class BottomNavBarNotifier extends _$BottomNavBarNotifier {
  @override
  int build() {
    return 0;
  }

  void changeIndex(int value) {
    state = value;
  }
}
