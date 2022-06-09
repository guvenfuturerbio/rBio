// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'credit_card_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreditCardState {
  CreditCardResult get result => throw _privateConstructorUsedError;
  CreditCardStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreditCardStateCopyWith<CreditCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditCardStateCopyWith<$Res> {
  factory $CreditCardStateCopyWith(
          CreditCardState value, $Res Function(CreditCardState) then) =
      _$CreditCardStateCopyWithImpl<$Res>;
  $Res call({CreditCardResult result, CreditCardStatus status});
}

/// @nodoc
class _$CreditCardStateCopyWithImpl<$Res>
    implements $CreditCardStateCopyWith<$Res> {
  _$CreditCardStateCopyWithImpl(this._value, this._then);

  final CreditCardState _value;
  // ignore: unused_field
  final $Res Function(CreditCardState) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CreditCardResult,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreditCardStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_CreditCardStateCopyWith<$Res>
    implements $CreditCardStateCopyWith<$Res> {
  factory _$$_CreditCardStateCopyWith(
          _$_CreditCardState value, $Res Function(_$_CreditCardState) then) =
      __$$_CreditCardStateCopyWithImpl<$Res>;
  @override
  $Res call({CreditCardResult result, CreditCardStatus status});
}

/// @nodoc
class __$$_CreditCardStateCopyWithImpl<$Res>
    extends _$CreditCardStateCopyWithImpl<$Res>
    implements _$$_CreditCardStateCopyWith<$Res> {
  __$$_CreditCardStateCopyWithImpl(
      _$_CreditCardState _value, $Res Function(_$_CreditCardState) _then)
      : super(_value, (v) => _then(v as _$_CreditCardState));

  @override
  _$_CreditCardState get _value => super._value as _$_CreditCardState;

  @override
  $Res call({
    Object? result = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_CreditCardState(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CreditCardResult,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreditCardStatus,
    ));
  }
}

/// @nodoc

class _$_CreditCardState extends _CreditCardState {
  const _$_CreditCardState(
      {this.result = const CreditCardResult(),
      this.status = CreditCardStatus.initial})
      : super._();

  @override
  @JsonKey()
  final CreditCardResult result;
  @override
  @JsonKey()
  final CreditCardStatus status;

  @override
  String toString() {
    return 'CreditCardState(result: $result, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreditCardState &&
            const DeepCollectionEquality().equals(other.result, result) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(result),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_CreditCardStateCopyWith<_$_CreditCardState> get copyWith =>
      __$$_CreditCardStateCopyWithImpl<_$_CreditCardState>(this, _$identity);
}

abstract class _CreditCardState extends CreditCardState {
  const factory _CreditCardState(
      {final CreditCardResult result,
      final CreditCardStatus status}) = _$_CreditCardState;
  const _CreditCardState._() : super._();

  @override
  CreditCardResult get result => throw _privateConstructorUsedError;
  @override
  CreditCardStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CreditCardStateCopyWith<_$_CreditCardState> get copyWith =>
      throw _privateConstructorUsedError;
}
