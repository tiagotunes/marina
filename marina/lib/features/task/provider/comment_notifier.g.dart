// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentNotifierHash() => r'badf7c72bf6794c29a9bd1e64e2a0b519b19c005';

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

abstract class _$CommentNotifier extends BuildlessAutoDisposeNotifier<String> {
  late final String comment;

  String build(String comment);
}

/// See also [CommentNotifier].
@ProviderFor(CommentNotifier)
const commentNotifierProvider = CommentNotifierFamily();

/// See also [CommentNotifier].
class CommentNotifierFamily extends Family<String> {
  /// See also [CommentNotifier].
  const CommentNotifierFamily();

  /// See also [CommentNotifier].
  CommentNotifierProvider call(String comment) {
    return CommentNotifierProvider(comment);
  }

  @override
  CommentNotifierProvider getProviderOverride(
    covariant CommentNotifierProvider provider,
  ) {
    return call(provider.comment);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'commentNotifierProvider';
}

/// See also [CommentNotifier].
class CommentNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CommentNotifier, String> {
  /// See also [CommentNotifier].
  CommentNotifierProvider(String comment)
    : this._internal(
        () => CommentNotifier()..comment = comment,
        from: commentNotifierProvider,
        name: r'commentNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$commentNotifierHash,
        dependencies: CommentNotifierFamily._dependencies,
        allTransitiveDependencies:
            CommentNotifierFamily._allTransitiveDependencies,
        comment: comment,
      );

  CommentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comment,
  }) : super.internal();

  final String comment;

  @override
  String runNotifierBuild(covariant CommentNotifier notifier) {
    return notifier.build(comment);
  }

  @override
  Override overrideWith(CommentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentNotifierProvider._internal(
        () => create()..comment = comment,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        comment: comment,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CommentNotifier, String> createElement() {
    return _CommentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentNotifierProvider && other.comment == comment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, comment.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommentNotifierRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `comment` of this provider.
  String get comment;
}

class _CommentNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CommentNotifier, String>
    with CommentNotifierRef {
  _CommentNotifierProviderElement(super.provider);

  @override
  String get comment => (origin as CommentNotifierProvider).comment;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
