import 'package:marina/common/utils/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measure_notifier.g.dart';

@Riverpod(keepAlive: true)
class MeasureNotifier extends _$MeasureNotifier {
  @override
  DataMap build() {
    return {};
  }

  void setAll(Map<String, int> values) {
    state = {...values};
  }

  void setValue(String measureId, int value) {
    state = {...state, measureId: value};
  }

  void clear() {
    state = {};
  }
}
