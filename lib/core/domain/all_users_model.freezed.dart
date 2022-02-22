// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'all_users_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllUsersModel _$AllUsersModelFromJson(Map<String, dynamic> json) {
  return _AllUsersModel.fromJson(json);
}

/// @nodoc
class _$AllUsersModelTearOff {
  const _$AllUsersModelTearOff();

  _AllUsersModel call({@JsonKey(name: 'useWidgets') List<String>? useWidgets}) {
    return _AllUsersModel(
      useWidgets: useWidgets,
    );
  }

  AllUsersModel fromJson(Map<String, Object?> json) {
    return AllUsersModel.fromJson(json);
  }
}

/// @nodoc
const $AllUsersModel = _$AllUsersModelTearOff();

/// @nodoc
mixin _$AllUsersModel {
  @JsonKey(name: 'useWidgets')
  List<String>? get useWidgets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllUsersModelCopyWith<AllUsersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllUsersModelCopyWith<$Res> {
  factory $AllUsersModelCopyWith(
          AllUsersModel value, $Res Function(AllUsersModel) then) =
      _$AllUsersModelCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'useWidgets') List<String>? useWidgets});
}

/// @nodoc
class _$AllUsersModelCopyWithImpl<$Res>
    implements $AllUsersModelCopyWith<$Res> {
  _$AllUsersModelCopyWithImpl(this._value, this._then);

  final AllUsersModel _value;
  // ignore: unused_field
  final $Res Function(AllUsersModel) _then;

  @override
  $Res call({
    Object? useWidgets = freezed,
  }) {
    return _then(_value.copyWith(
      useWidgets: useWidgets == freezed
          ? _value.useWidgets
          : useWidgets // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$AllUsersModelCopyWith<$Res>
    implements $AllUsersModelCopyWith<$Res> {
  factory _$AllUsersModelCopyWith(
          _AllUsersModel value, $Res Function(_AllUsersModel) then) =
      __$AllUsersModelCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'useWidgets') List<String>? useWidgets});
}

/// @nodoc
class __$AllUsersModelCopyWithImpl<$Res>
    extends _$AllUsersModelCopyWithImpl<$Res>
    implements _$AllUsersModelCopyWith<$Res> {
  __$AllUsersModelCopyWithImpl(
      _AllUsersModel _value, $Res Function(_AllUsersModel) _then)
      : super(_value, (v) => _then(v as _AllUsersModel));

  @override
  _AllUsersModel get _value => super._value as _AllUsersModel;

  @override
  $Res call({
    Object? useWidgets = freezed,
  }) {
    return _then(_AllUsersModel(
      useWidgets: useWidgets == freezed
          ? _value.useWidgets
          : useWidgets // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllUsersModel implements _AllUsersModel {
  const _$_AllUsersModel({@JsonKey(name: 'useWidgets') this.useWidgets});

  factory _$_AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$$_AllUsersModelFromJson(json);

  @override
  @JsonKey(name: 'useWidgets')
  final List<String>? useWidgets;

  @override
  String toString() {
    return 'AllUsersModel(useWidgets: $useWidgets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AllUsersModel &&
            const DeepCollectionEquality()
                .equals(other.useWidgets, useWidgets));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(useWidgets));

  @JsonKey(ignore: true)
  @override
  _$AllUsersModelCopyWith<_AllUsersModel> get copyWith =>
      __$AllUsersModelCopyWithImpl<_AllUsersModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllUsersModelToJson(this);
  }
}

abstract class _AllUsersModel implements AllUsersModel {
  const factory _AllUsersModel(
          {@JsonKey(name: 'useWidgets') List<String>? useWidgets}) =
      _$_AllUsersModel;

  factory _AllUsersModel.fromJson(Map<String, dynamic> json) =
      _$_AllUsersModel.fromJson;

  @override
  @JsonKey(name: 'useWidgets')
  List<String>? get useWidgets;
  @override
  @JsonKey(ignore: true)
  _$AllUsersModelCopyWith<_AllUsersModel> get copyWith =>
      throw _privateConstructorUsedError;
}
