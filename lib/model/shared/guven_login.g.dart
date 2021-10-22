// GENERATED CODE - DO NOT MODIFY BY HAND

part of guven_login;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GuvenLogin> _$guvenLoginSerializer = new _$GuvenLoginSerializer();

class _$GuvenLoginSerializer implements StructuredSerializer<GuvenLogin> {
  @override
  final Iterable<Type> types = const [GuvenLogin, _$GuvenLogin];
  @override
  final String wireName = 'GuvenLogin';

  @override
  Iterable<Object> serialize(Serializers serializers, GuvenLogin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'access_token',
      serializers.serialize(object.access_token,
          specifiedType: const FullType(String)),
      'expires_in',
      serializers.serialize(object.expires_in,
          specifiedType: const FullType(int)),
      'refresh_expires_in',
      serializers.serialize(object.refresh_expires_in,
          specifiedType: const FullType(int)),
      'refresh_token',
      serializers.serialize(object.refresh_token,
          specifiedType: const FullType(String)),
      'token_type',
      serializers.serialize(object.token_type,
          specifiedType: const FullType(String)),
      'id_token',
      serializers.serialize(object.id_token,
          specifiedType: const FullType(String)),
      'session_state',
      serializers.serialize(object.session_state,
          specifiedType: const FullType(String)),
      'scope',
      serializers.serialize(object.scope,
          specifiedType: const FullType(String)),
    ];
    if (object.not_before_policy != null) {
      result
        ..add('not_before_policy')
        ..add(serializers.serialize(object.not_before_policy,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GuvenLogin deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GuvenLoginBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'access_token':
          result.access_token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expires_in':
          result.expires_in = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'refresh_expires_in':
          result.refresh_expires_in = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'refresh_token':
          result.refresh_token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token_type':
          result.token_type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_token':
          result.id_token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'not_before_policy':
          result.not_before_policy = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'session_state':
          result.session_state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'scope':
          result.scope = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GuvenLogin extends GuvenLogin {
  @override
  final String access_token;
  @override
  final int expires_in;
  @override
  final int refresh_expires_in;
  @override
  final String refresh_token;
  @override
  final String token_type;
  @override
  final String id_token;
  @override
  final int not_before_policy;
  @override
  final String session_state;
  @override
  final String scope;

  factory _$GuvenLogin([void Function(GuvenLoginBuilder) updates]) =>
      (new GuvenLoginBuilder()..update(updates)).build();

  _$GuvenLogin._(
      {this.access_token,
      this.expires_in,
      this.refresh_expires_in,
      this.refresh_token,
      this.token_type,
      this.id_token,
      this.not_before_policy,
      this.session_state,
      this.scope})
      : super._() {
    if (access_token == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'access_token');
    }
    if (expires_in == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'expires_in');
    }
    if (refresh_expires_in == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'refresh_expires_in');
    }
    if (refresh_token == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'refresh_token');
    }
    if (token_type == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'token_type');
    }
    if (id_token == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'id_token');
    }
    if (session_state == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'session_state');
    }
    if (scope == null) {
      throw new BuiltValueNullFieldError('GuvenLogin', 'scope');
    }
  }

  @override
  GuvenLogin rebuild(void Function(GuvenLoginBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GuvenLoginBuilder toBuilder() => new GuvenLoginBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GuvenLogin &&
        access_token == other.access_token &&
        expires_in == other.expires_in &&
        refresh_expires_in == other.refresh_expires_in &&
        refresh_token == other.refresh_token &&
        token_type == other.token_type &&
        id_token == other.id_token &&
        not_before_policy == other.not_before_policy &&
        session_state == other.session_state &&
        scope == other.scope;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, access_token.hashCode),
                                    expires_in.hashCode),
                                refresh_expires_in.hashCode),
                            refresh_token.hashCode),
                        token_type.hashCode),
                    id_token.hashCode),
                not_before_policy.hashCode),
            session_state.hashCode),
        scope.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GuvenLogin')
          ..add('access_token', access_token)
          ..add('expires_in', expires_in)
          ..add('refresh_expires_in', refresh_expires_in)
          ..add('refresh_token', refresh_token)
          ..add('token_type', token_type)
          ..add('id_token', id_token)
          ..add('not_before_policy', not_before_policy)
          ..add('session_state', session_state)
          ..add('scope', scope))
        .toString();
  }
}

class GuvenLoginBuilder implements Builder<GuvenLogin, GuvenLoginBuilder> {
  _$GuvenLogin _$v;

  String _access_token;
  String get access_token => _$this._access_token;
  set access_token(String access_token) => _$this._access_token = access_token;

  int _expires_in;
  int get expires_in => _$this._expires_in;
  set expires_in(int expires_in) => _$this._expires_in = expires_in;

  int _refresh_expires_in;
  int get refresh_expires_in => _$this._refresh_expires_in;
  set refresh_expires_in(int refresh_expires_in) =>
      _$this._refresh_expires_in = refresh_expires_in;

  String _refresh_token;
  String get refresh_token => _$this._refresh_token;
  set refresh_token(String refresh_token) =>
      _$this._refresh_token = refresh_token;

  String _token_type;
  String get token_type => _$this._token_type;
  set token_type(String token_type) => _$this._token_type = token_type;

  String _id_token;
  String get id_token => _$this._id_token;
  set id_token(String id_token) => _$this._id_token = id_token;

  int _not_before_policy;
  int get not_before_policy => _$this._not_before_policy;
  set not_before_policy(int not_before_policy) =>
      _$this._not_before_policy = not_before_policy;

  String _session_state;
  String get session_state => _$this._session_state;
  set session_state(String session_state) =>
      _$this._session_state = session_state;

  String _scope;
  String get scope => _$this._scope;
  set scope(String scope) => _$this._scope = scope;

  GuvenLoginBuilder();

  GuvenLoginBuilder get _$this {
    if (_$v != null) {
      _access_token = _$v.access_token;
      _expires_in = _$v.expires_in;
      _refresh_expires_in = _$v.refresh_expires_in;
      _refresh_token = _$v.refresh_token;
      _token_type = _$v.token_type;
      _id_token = _$v.id_token;
      _not_before_policy = _$v.not_before_policy;
      _session_state = _$v.session_state;
      _scope = _$v.scope;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GuvenLogin other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GuvenLogin;
  }

  @override
  void update(void Function(GuvenLoginBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GuvenLogin build() {
    final _$result = _$v ??
        new _$GuvenLogin._(
            access_token: access_token,
            expires_in: expires_in,
            refresh_expires_in: refresh_expires_in,
            refresh_token: refresh_token,
            token_type: token_type,
            id_token: id_token,
            not_before_policy: not_before_policy,
            session_state: session_state,
            scope: scope);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
