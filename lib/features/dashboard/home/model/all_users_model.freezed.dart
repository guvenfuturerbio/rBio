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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllUsersModel _$AllUsersModelFromJson(Map<String, dynamic> json) {
  return _AllUsersModel.fromJson(json);
}

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
abstract class _$$_AllUsersModelCopyWith<$Res>
    implements $AllUsersModelCopyWith<$Res> {
  factory _$$_AllUsersModelCopyWith(
          _$_AllUsersModel value, $Res Function(_$_AllUsersModel) then) =
      __$$_AllUsersModelCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'useWidgets') List<String>? useWidgets});
}

/// @nodoc
class __$$_AllUsersModelCopyWithImpl<$Res>
    extends _$AllUsersModelCopyWithImpl<$Res>
    implements _$$_AllUsersModelCopyWith<$Res> {
  __$$_AllUsersModelCopyWithImpl(
      _$_AllUsersModel _value, $Res Function(_$_AllUsersModel) _then)
      : super(_value, (v) => _then(v as _$_AllUsersModel));

  @override
  _$_AllUsersModel get _value => super._value as _$_AllUsersModel;

  @override
  $Res call({
    Object? useWidgets = freezed,
  }) {
    return _then(_$_AllUsersModel(
      useWidgets: useWidgets == freezed
          ? _value._useWidgets
          : useWidgets // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllUsersModel implements _AllUsersModel {
  const _$_AllUsersModel(
      {@JsonKey(name: 'useWidgets') final List<String>? useWidgets})
      : _useWidgets = useWidgets;

  factory _$_AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$$_AllUsersModelFromJson(json);

  final List<String>? _useWidgets;
  @override
  @JsonKey(name: 'useWidgets')
  List<String>? get useWidgets {
    final value = _useWidgets;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AllUsersModel(useWidgets: $useWidgets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllUsersModel &&
            const DeepCollectionEquality()
                .equals(other._useWidgets, _useWidgets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_useWidgets));

  @JsonKey(ignore: true)
  @override
  _$$_AllUsersModelCopyWith<_$_AllUsersModel> get copyWith =>
      __$$_AllUsersModelCopyWithImpl<_$_AllUsersModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllUsersModelToJson(this);
  }
}

abstract class _AllUsersModel implements AllUsersModel {
  const factory _AllUsersModel(
          {@JsonKey(name: 'useWidgets') final List<String>? useWidgets}) =
      _$_AllUsersModel;

  factory _AllUsersModel.fromJson(Map<String, dynamic> json) =
      _$_AllUsersModel.fromJson;

  @override
  @JsonKey(name: 'useWidgets')
  List<String>? get useWidgets => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AllUsersModelCopyWith<_$_AllUsersModel> get copyWith =>
      throw _privateConstructorUsedError;
}
