// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userTasksNotifierHash() => r'46c8c6f91e3344b580183c55aa0c11d993632efe';

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

abstract class _$UserTasksNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<UserTask>> {
  late final String userId;

  FutureOr<List<UserTask>> build(String userId);
}

/// See also [UserTasksNotifier].
@ProviderFor(UserTasksNotifier)
const userTasksNotifierProvider = UserTasksNotifierFamily();

/// See also [UserTasksNotifier].
class UserTasksNotifierFamily extends Family<AsyncValue<List<UserTask>>> {
  /// See also [UserTasksNotifier].
  const UserTasksNotifierFamily();

  /// See also [UserTasksNotifier].
  UserTasksNotifierProvider call(String userId) {
    return UserTasksNotifierProvider(userId);
  }

  @override
  UserTasksNotifierProvider getProviderOverride(
    covariant UserTasksNotifierProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userTasksNotifierProvider';
}

/// See also [UserTasksNotifier].
class UserTasksNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          UserTasksNotifier,
          List<UserTask>
        > {
  /// See also [UserTasksNotifier].
  UserTasksNotifierProvider(String userId)
    : this._internal(
        () => UserTasksNotifier()..userId = userId,
        from: userTasksNotifierProvider,
        name: r'userTasksNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userTasksNotifierHash,
        dependencies: UserTasksNotifierFamily._dependencies,
        allTransitiveDependencies:
            UserTasksNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserTasksNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<UserTask>> runNotifierBuild(
    covariant UserTasksNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(UserTasksNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserTasksNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserTasksNotifier, List<UserTask>>
  createElement() {
    return _UserTasksNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTasksNotifierProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserTasksNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<UserTask>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserTasksNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          UserTasksNotifier,
          List<UserTask>
        >
    with UserTasksNotifierRef {
  _UserTasksNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as UserTasksNotifierProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
