// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatroomsJoinedHash() => r'3a2db4159663c54dfd7bc40519e2faa6df69b41f';

/// See also [chatroomsJoined].
@ProviderFor(chatroomsJoined)
final chatroomsJoinedProvider =
    AutoDisposeFutureProvider<List<SnChat>>.internal(
      chatroomsJoined,
      name: r'chatroomsJoinedProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$chatroomsJoinedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatroomsJoinedRef = AutoDisposeFutureProviderRef<List<SnChat>>;
String _$chatroomHash() => r'27bd4cb49326bb2f2eac7d7db9db7f610e21afb2';

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

/// See also [chatroom].
@ProviderFor(chatroom)
const chatroomProvider = ChatroomFamily();

/// See also [chatroom].
class ChatroomFamily extends Family<AsyncValue<SnChat?>> {
  /// See also [chatroom].
  const ChatroomFamily();

  /// See also [chatroom].
  ChatroomProvider call(int? identifier) {
    return ChatroomProvider(identifier);
  }

  @override
  ChatroomProvider getProviderOverride(covariant ChatroomProvider provider) {
    return call(provider.identifier);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatroomProvider';
}

/// See also [chatroom].
class ChatroomProvider extends AutoDisposeFutureProvider<SnChat?> {
  /// See also [chatroom].
  ChatroomProvider(int? identifier)
    : this._internal(
        (ref) => chatroom(ref as ChatroomRef, identifier),
        from: chatroomProvider,
        name: r'chatroomProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$chatroomHash,
        dependencies: ChatroomFamily._dependencies,
        allTransitiveDependencies: ChatroomFamily._allTransitiveDependencies,
        identifier: identifier,
      );

  ChatroomProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.identifier,
  }) : super.internal();

  final int? identifier;

  @override
  Override overrideWith(
    FutureOr<SnChat?> Function(ChatroomRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatroomProvider._internal(
        (ref) => create(ref as ChatroomRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        identifier: identifier,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SnChat?> createElement() {
    return _ChatroomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatroomProvider && other.identifier == identifier;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, identifier.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatroomRef on AutoDisposeFutureProviderRef<SnChat?> {
  /// The parameter `identifier` of this provider.
  int? get identifier;
}

class _ChatroomProviderElement extends AutoDisposeFutureProviderElement<SnChat?>
    with ChatroomRef {
  _ChatroomProviderElement(super.provider);

  @override
  int? get identifier => (origin as ChatroomProvider).identifier;
}

String _$chatroomIdentityHash() => r'b20322591279d0336f2f309729e7e0cb9809063f';

/// See also [chatroomIdentity].
@ProviderFor(chatroomIdentity)
const chatroomIdentityProvider = ChatroomIdentityFamily();

/// See also [chatroomIdentity].
class ChatroomIdentityFamily extends Family<AsyncValue<SnChatMember?>> {
  /// See also [chatroomIdentity].
  const ChatroomIdentityFamily();

  /// See also [chatroomIdentity].
  ChatroomIdentityProvider call(int? identifier) {
    return ChatroomIdentityProvider(identifier);
  }

  @override
  ChatroomIdentityProvider getProviderOverride(
    covariant ChatroomIdentityProvider provider,
  ) {
    return call(provider.identifier);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatroomIdentityProvider';
}

/// See also [chatroomIdentity].
class ChatroomIdentityProvider
    extends AutoDisposeFutureProvider<SnChatMember?> {
  /// See also [chatroomIdentity].
  ChatroomIdentityProvider(int? identifier)
    : this._internal(
        (ref) => chatroomIdentity(ref as ChatroomIdentityRef, identifier),
        from: chatroomIdentityProvider,
        name: r'chatroomIdentityProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$chatroomIdentityHash,
        dependencies: ChatroomIdentityFamily._dependencies,
        allTransitiveDependencies:
            ChatroomIdentityFamily._allTransitiveDependencies,
        identifier: identifier,
      );

  ChatroomIdentityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.identifier,
  }) : super.internal();

  final int? identifier;

  @override
  Override overrideWith(
    FutureOr<SnChatMember?> Function(ChatroomIdentityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatroomIdentityProvider._internal(
        (ref) => create(ref as ChatroomIdentityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        identifier: identifier,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SnChatMember?> createElement() {
    return _ChatroomIdentityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatroomIdentityProvider && other.identifier == identifier;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, identifier.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatroomIdentityRef on AutoDisposeFutureProviderRef<SnChatMember?> {
  /// The parameter `identifier` of this provider.
  int? get identifier;
}

class _ChatroomIdentityProviderElement
    extends AutoDisposeFutureProviderElement<SnChatMember?>
    with ChatroomIdentityRef {
  _ChatroomIdentityProviderElement(super.provider);

  @override
  int? get identifier => (origin as ChatroomIdentityProvider).identifier;
}

String _$chatroomInvitesHash() => r'c15f06c1e9c6074e6159d9d1f4404f31250ce523';

/// See also [chatroomInvites].
@ProviderFor(chatroomInvites)
final chatroomInvitesProvider =
    AutoDisposeFutureProvider<List<SnChatMember>>.internal(
      chatroomInvites,
      name: r'chatroomInvitesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$chatroomInvitesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatroomInvitesRef = AutoDisposeFutureProviderRef<List<SnChatMember>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
