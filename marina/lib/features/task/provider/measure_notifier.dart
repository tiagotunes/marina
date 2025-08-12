import 'package:marina/common/models/measure.dart';
import 'package:marina/common/utils/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measure_notifier.g.dart';

@riverpod
class MeasureNotifier extends _$MeasureNotifier {
  @override
  DataMap build(List<Measure> measures) {
    final initialValues = <String, int>{};
    for (final measure in measures) {
      final val = measure.value ?? 0;
      if (val != 0 && measure.id != null) {
        initialValues[measure.id!] = val;
      }
    }
    return initialValues;
  }

  void setValue(String measureId, int value) {
    final currentValue = state[measureId];
    if (currentValue == value) {
      // If same value tapped → remove it
      final newState = Map.of(state)..remove(measureId);
      state = newState;
    } else {
      // Otherwise → set new value
      state = {...state, measureId: value};
    }
  }

  int? getValue(String measureId) {
    return state[measureId];
  }
}
