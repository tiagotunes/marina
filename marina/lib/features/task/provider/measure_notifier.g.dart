// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measure_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$measureNotifierHash() => r'4f6a664990a58c6f05135eb05458b8a6eee96416';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MeasureNotifier extends BuildlessAutoDisposeNotifier<DataMap> {
  late final List<Measure> measures;

  DataMap build(List<Measure> measures);
}

/// See also [MeasureNotifier].
@ProviderFor(MeasureNotifier)
const measureNotifierProvider = MeasureNotifierFamily();

/// See also [MeasureNotifier].
class MeasureNotifierFamily extends Family<DataMap> {
  /// See also [MeasureNotifier].
  const MeasureNotifierFamily();

  /// See also [MeasureNotifier].
  MeasureNotifierProvider call(List<Measure> measures) {
    return MeasureNotifierProvider(measures);
  }

  @override
  MeasureNotifierProvider getProviderOverride(
    covariant MeasureNotifierProvider provider,
  ) {
    return call(provider.measures);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'measureNotifierProvider';
}

/// See also [MeasureNotifier].
class MeasureNotifierProvider
    extends AutoDisposeNotifierProviderImpl<MeasureNotifier, DataMap> {
  /// See also [MeasureNotifier].
  MeasureNotifierProvider(List<Measure> measures)
    : this._internal(
        () => MeasureNotifier()..measures = measures,
        from: measureNotifierProvider,
        name: r'measureNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$measureNotifierHash,
        dependencies: MeasureNotifierFamily._dependencies,
        allTransitiveDependencies:
            MeasureNotifierFamily._allTransitiveDependencies,
        measures: measures,
      );

  MeasureNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.measures,
  }) : super.internal();

  final List<Measure> measures;

  @override
  DataMap runNotifierBuild(covariant MeasureNotifier notifier) {
    return notifier.build(measures);
  }

  @override
  Override overrideWith(MeasureNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MeasureNotifierProvider._internal(
        () => create()..measures = measures,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        measures: measures,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MeasureNotifier, DataMap> createElement() {
    return _MeasureNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MeasureNotifierProvider && other.measures == measures;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, measures.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MeasureNotifierRef on AutoDisposeNotifierProviderRef<DataMap> {
  /// The parameter `measures` of this provider.
  List<Measure> get measures;
}

class _MeasureNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<MeasureNotifier, DataMap>
    with MeasureNotifierRef {
  _MeasureNotifierProviderElement(super.provider);

  @override
  List<Measure> get measures => (origin as MeasureNotifierProvider).measures;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
