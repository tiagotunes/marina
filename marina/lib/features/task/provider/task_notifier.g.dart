// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskNotifierHash() => r'678fbd1a4fdc562ec2ef1b7f296183fdc16a2d8e';

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

abstract class _$TaskNotifier
    extends BuildlessAutoDisposeAsyncNotifier<TaskModel> {
  late final String taskId;

  FutureOr<TaskModel> build(String taskId);
}

/// See also [TaskNotifier].
@ProviderFor(TaskNotifier)
const taskNotifierProvider = TaskNotifierFamily();

/// See also [TaskNotifier].
class TaskNotifierFamily extends Family<AsyncValue<TaskModel>> {
  /// See also [TaskNotifier].
  const TaskNotifierFamily();

  /// See also [TaskNotifier].
  TaskNotifierProvider call(String taskId) {
    return TaskNotifierProvider(taskId);
  }

  @override
  TaskNotifierProvider getProviderOverride(
    covariant TaskNotifierProvider provider,
  ) {
    return call(provider.taskId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskNotifierProvider';
}

/// See also [TaskNotifier].
class TaskNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TaskNotifier, TaskModel> {
  /// See also [TaskNotifier].
  TaskNotifierProvider(String taskId)
    : this._internal(
        () => TaskNotifier()..taskId = taskId,
        from: taskNotifierProvider,
        name: r'taskNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$taskNotifierHash,
        dependencies: TaskNotifierFamily._dependencies,
        allTransitiveDependencies:
            TaskNotifierFamily._allTransitiveDependencies,
        taskId: taskId,
      );

  TaskNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  FutureOr<TaskModel> runNotifierBuild(covariant TaskNotifier notifier) {
    return notifier.build(taskId);
  }

  @override
  Override overrideWith(TaskNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskNotifierProvider._internal(
        () => create()..taskId = taskId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TaskNotifier, TaskModel>
  createElement() {
    return _TaskNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskNotifierProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskNotifierRef on AutoDisposeAsyncNotifierProviderRef<TaskModel> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _TaskNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskNotifier, TaskModel>
    with TaskNotifierRef {
  _TaskNotifierProviderElement(super.provider);

  @override
  String get taskId => (origin as TaskNotifierProvider).taskId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
