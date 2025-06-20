// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_adapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authAdapterHash() => r'c4f405b5cd5ec9f08c6518845b5440011ab1ebf8';

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

abstract class _$AuthAdapter extends BuildlessAutoDisposeNotifier<AuthState> {
  late final GlobalKey<State<StatefulWidget>>? familyKey;

  AuthState build([GlobalKey<State<StatefulWidget>>? familyKey]);
}

/// See also [AuthAdapter].
@ProviderFor(AuthAdapter)
const authAdapterProvider = AuthAdapterFamily();

/// See also [AuthAdapter].
class AuthAdapterFamily extends Family<AuthState> {
  /// See also [AuthAdapter].
  const AuthAdapterFamily();

  /// See also [AuthAdapter].
  AuthAdapterProvider call([GlobalKey<State<StatefulWidget>>? familyKey]) {
    return AuthAdapterProvider(familyKey);
  }

  @override
  AuthAdapterProvider getProviderOverride(
    covariant AuthAdapterProvider provider,
  ) {
    return call(provider.familyKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authAdapterProvider';
}

/// See also [AuthAdapter].
class AuthAdapterProvider
    extends AutoDisposeNotifierProviderImpl<AuthAdapter, AuthState> {
  /// See also [AuthAdapter].
  AuthAdapterProvider([GlobalKey<State<StatefulWidget>>? familyKey])
    : this._internal(
        () => AuthAdapter()..familyKey = familyKey,
        from: authAdapterProvider,
        name: r'authAdapterProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$authAdapterHash,
        dependencies: AuthAdapterFamily._dependencies,
        allTransitiveDependencies: AuthAdapterFamily._allTransitiveDependencies,
        familyKey: familyKey,
      );

  AuthAdapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.familyKey,
  }) : super.internal();

  final GlobalKey<State<StatefulWidget>>? familyKey;

  @override
  AuthState runNotifierBuild(covariant AuthAdapter notifier) {
    return notifier.build(familyKey);
  }

  @override
  Override overrideWith(AuthAdapter Function() create) {
    return ProviderOverride(
      origin: this,
      override: AuthAdapterProvider._internal(
        () => create()..familyKey = familyKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        familyKey: familyKey,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AuthAdapter, AuthState> createElement() {
    return _AuthAdapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthAdapterProvider && other.familyKey == familyKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, familyKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthAdapterRef on AutoDisposeNotifierProviderRef<AuthState> {
  /// The parameter `familyKey` of this provider.
  GlobalKey<State<StatefulWidget>>? get familyKey;
}

class _AuthAdapterProviderElement
    extends AutoDisposeNotifierProviderElement<AuthAdapter, AuthState>
    with AuthAdapterRef {
  _AuthAdapterProviderElement(super.provider);

  @override
  GlobalKey<State<StatefulWidget>>? get familyKey =>
      (origin as AuthAdapterProvider).familyKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
