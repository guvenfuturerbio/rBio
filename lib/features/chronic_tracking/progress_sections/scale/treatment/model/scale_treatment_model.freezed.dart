// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_treatment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScaleResponseModel _$ScaleResponseModelFromJson(Map<String, dynamic> json) {
  return _ScaleResponseModel.fromJson(json);
}

/// @nodoc
class _$ScaleResponseModelTearOff {
  const _$ScaleResponseModelTearOff();

  _ScaleResponseModel call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          bool? doctorNoteList}) {
    return _ScaleResponseModel(
      treatmentNoteList: treatmentNoteList,
      dietList: dietList,
      doctorNoteList: doctorNoteList,
    );
  }

  ScaleResponseModel fromJson(Map<String, Object?> json) {
    return ScaleResponseModel.fromJson(json);
  }
}

/// @nodoc
const $ScaleResponseModel = _$ScaleResponseModelTearOff();

/// @nodoc
mixin _$ScaleResponseModel {
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'doctorNoteList')
  bool? get doctorNoteList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleResponseModelCopyWith<ScaleResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleResponseModelCopyWith<$Res> {
  factory $ScaleResponseModelCopyWith(
          ScaleResponseModel value, $Res Function(ScaleResponseModel) then) =
      _$ScaleResponseModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          bool? doctorNoteList});
}

/// @nodoc
class _$ScaleResponseModelCopyWithImpl<$Res>
    implements $ScaleResponseModelCopyWith<$Res> {
  _$ScaleResponseModelCopyWithImpl(this._value, this._then);

  final ScaleResponseModel _value;
  // ignore: unused_field
  final $Res Function(ScaleResponseModel) _then;

  @override
  $Res call({
    Object? treatmentNoteList = freezed,
    Object? dietList = freezed,
    Object? doctorNoteList = freezed,
  }) {
    return _then(_value.copyWith(
      treatmentNoteList: treatmentNoteList == freezed
          ? _value.treatmentNoteList
          : treatmentNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentModel>?,
      dietList: dietList == freezed
          ? _value.dietList
          : dietList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDietModel>?,
      doctorNoteList: doctorNoteList == freezed
          ? _value.doctorNoteList
          : doctorNoteList // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$ScaleResponseModelCopyWith<$Res>
    implements $ScaleResponseModelCopyWith<$Res> {
  factory _$ScaleResponseModelCopyWith(
          _ScaleResponseModel value, $Res Function(_ScaleResponseModel) then) =
      __$ScaleResponseModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          bool? doctorNoteList});
}

/// @nodoc
class __$ScaleResponseModelCopyWithImpl<$Res>
    extends _$ScaleResponseModelCopyWithImpl<$Res>
    implements _$ScaleResponseModelCopyWith<$Res> {
  __$ScaleResponseModelCopyWithImpl(
      _ScaleResponseModel _value, $Res Function(_ScaleResponseModel) _then)
      : super(_value, (v) => _then(v as _ScaleResponseModel));

  @override
  _ScaleResponseModel get _value => super._value as _ScaleResponseModel;

  @override
  $Res call({
    Object? treatmentNoteList = freezed,
    Object? dietList = freezed,
    Object? doctorNoteList = freezed,
  }) {
    return _then(_ScaleResponseModel(
      treatmentNoteList: treatmentNoteList == freezed
          ? _value.treatmentNoteList
          : treatmentNoteList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentModel>?,
      dietList: dietList == freezed
          ? _value.dietList
          : dietList // ignore: cast_nullable_to_non_nullable
              as List<ScaleTreatmentDietModel>?,
      doctorNoteList: doctorNoteList == freezed
          ? _value.doctorNoteList
          : doctorNoteList // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleResponseModel extends _ScaleResponseModel {
  const _$_ScaleResponseModel(
      {@JsonKey(name: 'treatmentNoteList') this.treatmentNoteList,
      @JsonKey(name: 'dietList') this.dietList,
      @JsonKey(name: 'doctorNoteList') this.doctorNoteList})
      : super._();

  factory _$_ScaleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleResponseModelFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteList')
  final List<ScaleTreatmentModel>? treatmentNoteList;
  @override
  @JsonKey(name: 'dietList')
  final List<ScaleTreatmentDietModel>? dietList;
  @override
  @JsonKey(name: 'doctorNoteList')
  final bool? doctorNoteList;

  @override
  String toString() {
    return 'ScaleResponseModel(treatmentNoteList: $treatmentNoteList, dietList: $dietList, doctorNoteList: $doctorNoteList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleResponseModel &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteList, treatmentNoteList) &&
            const DeepCollectionEquality().equals(other.dietList, dietList) &&
            const DeepCollectionEquality()
                .equals(other.doctorNoteList, doctorNoteList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteList),
      const DeepCollectionEquality().hash(dietList),
      const DeepCollectionEquality().hash(doctorNoteList));

  @JsonKey(ignore: true)
  @override
  _$ScaleResponseModelCopyWith<_ScaleResponseModel> get copyWith =>
      __$ScaleResponseModelCopyWithImpl<_ScaleResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleResponseModelToJson(this);
  }
}

abstract class _ScaleResponseModel extends ScaleResponseModel {
  const factory _ScaleResponseModel(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          bool? doctorNoteList}) = _$_ScaleResponseModel;
  const _ScaleResponseModel._() : super._();

  factory _ScaleResponseModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleResponseModel.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList;
  @override
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList;
  @override
  @JsonKey(name: 'doctorNoteList')
  bool? get doctorNoteList;
  @override
  @JsonKey(ignore: true)
  _$ScaleResponseModelCopyWith<_ScaleResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ScaleTreatmentModel _$ScaleTreatmentModelFromJson(Map<String, dynamic> json) {
  return _ScaleTreatmentModel.fromJson(json);
}

/// @nodoc
class _$ScaleTreatmentModelTearOff {
  const _$ScaleTreatmentModelTearOff();

  _ScaleTreatmentModel call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'treatmentNoteId')
          int? treatmentNoteId,
      @JsonKey(name: 'createdByName')
          String? createdByName}) {
    return _ScaleTreatmentModel(
      treatmentNoteTitle: treatmentNoteTitle,
      treatmentNoteCreateDate: treatmentNoteCreateDate,
      treatmentNoteId: treatmentNoteId,
      createdByName: createdByName,
    );
  }

  ScaleTreatmentModel fromJson(Map<String, Object?> json) {
    return ScaleTreatmentModel.fromJson(json);
  }
}

/// @nodoc
const $ScaleTreatmentModel = _$ScaleTreatmentModelTearOff();

/// @nodoc
mixin _$ScaleTreatmentModel {
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteId')
  int? get treatmentNoteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentModelCopyWith<ScaleTreatmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentModelCopyWith<$Res> {
  factory $ScaleTreatmentModelCopyWith(
          ScaleTreatmentModel value, $Res Function(ScaleTreatmentModel) then) =
      _$ScaleTreatmentModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'treatmentNoteId')
          int? treatmentNoteId,
      @JsonKey(name: 'createdByName')
          String? createdByName});
}

/// @nodoc
class _$ScaleTreatmentModelCopyWithImpl<$Res>
    implements $ScaleTreatmentModelCopyWith<$Res> {
  _$ScaleTreatmentModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentModel) _then;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? treatmentNoteId = freezed,
    Object? createdByName = freezed,
  }) {
    return _then(_value.copyWith(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      treatmentNoteId: treatmentNoteId == freezed
          ? _value.treatmentNoteId
          : treatmentNoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ScaleTreatmentModelCopyWith<$Res>
    implements $ScaleTreatmentModelCopyWith<$Res> {
  factory _$ScaleTreatmentModelCopyWith(_ScaleTreatmentModel value,
          $Res Function(_ScaleTreatmentModel) then) =
      __$ScaleTreatmentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'treatmentNoteId')
          int? treatmentNoteId,
      @JsonKey(name: 'createdByName')
          String? createdByName});
}

/// @nodoc
class __$ScaleTreatmentModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentModelCopyWithImpl<$Res>
    implements _$ScaleTreatmentModelCopyWith<$Res> {
  __$ScaleTreatmentModelCopyWithImpl(
      _ScaleTreatmentModel _value, $Res Function(_ScaleTreatmentModel) _then)
      : super(_value, (v) => _then(v as _ScaleTreatmentModel));

  @override
  _ScaleTreatmentModel get _value => super._value as _ScaleTreatmentModel;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? treatmentNoteId = freezed,
    Object? createdByName = freezed,
  }) {
    return _then(_ScaleTreatmentModel(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      treatmentNoteId: treatmentNoteId == freezed
          ? _value.treatmentNoteId
          : treatmentNoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentModel extends _ScaleTreatmentModel {
  const _$_ScaleTreatmentModel(
      {@JsonKey(name: 'treatmentNoteTitle') this.treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate') this.treatmentNoteCreateDate,
      @JsonKey(name: 'treatmentNoteId') this.treatmentNoteId,
      @JsonKey(name: 'createdByName') this.createdByName})
      : super._();

  factory _$_ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentModelFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  final String? treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  final DateTime? treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'treatmentNoteId')
  final int? treatmentNoteId;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;

  @override
  String toString() {
    return 'ScaleTreatmentModel(treatmentNoteTitle: $treatmentNoteTitle, treatmentNoteCreateDate: $treatmentNoteCreateDate, treatmentNoteId: $treatmentNoteId, createdByName: $createdByName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleTreatmentModel &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteTitle, treatmentNoteTitle) &&
            const DeepCollectionEquality().equals(
                other.treatmentNoteCreateDate, treatmentNoteCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteId, treatmentNoteId) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteTitle),
      const DeepCollectionEquality().hash(treatmentNoteCreateDate),
      const DeepCollectionEquality().hash(treatmentNoteId),
      const DeepCollectionEquality().hash(createdByName));

  @JsonKey(ignore: true)
  @override
  _$ScaleTreatmentModelCopyWith<_ScaleTreatmentModel> get copyWith =>
      __$ScaleTreatmentModelCopyWithImpl<_ScaleTreatmentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentModelToJson(this);
  }
}

abstract class _ScaleTreatmentModel extends ScaleTreatmentModel {
  const factory _ScaleTreatmentModel(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'treatmentNoteId')
          int? treatmentNoteId,
      @JsonKey(name: 'createdByName')
          String? createdByName}) = _$_ScaleTreatmentModel;
  const _ScaleTreatmentModel._() : super._();

  factory _ScaleTreatmentModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentModel.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'treatmentNoteId')
  int? get treatmentNoteId;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentModelCopyWith<_ScaleTreatmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ScaleTreatmentDietModel _$ScaleTreatmentDietModelFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentDietModel.fromJson(json);
}

/// @nodoc
class _$ScaleTreatmentDietModelTearOff {
  const _$ScaleTreatmentDietModelTearOff();

  _ScaleTreatmentDietModel call(
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'dietId') int? dietId,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'dietBreakfast') String? dietBreakfast,
      @JsonKey(name: 'dietRefreshment') String? dietRefreshment,
      @JsonKey(name: 'dietLunch') String? dietLunch,
      @JsonKey(name: 'dietDinner') String? dietDinner}) {
    return _ScaleTreatmentDietModel(
      dietTitle: dietTitle,
      dietCreateDate: dietCreateDate,
      dietId: dietId,
      createdByName: createdByName,
      dietBreakfast: dietBreakfast,
      dietRefreshment: dietRefreshment,
      dietLunch: dietLunch,
      dietDinner: dietDinner,
    );
  }

  ScaleTreatmentDietModel fromJson(Map<String, Object?> json) {
    return ScaleTreatmentDietModel.fromJson(json);
  }
}

/// @nodoc
const $ScaleTreatmentDietModel = _$ScaleTreatmentDietModelTearOff();

/// @nodoc
mixin _$ScaleTreatmentDietModel {
  @JsonKey(name: 'dietTitle')
  String? get dietTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietCreateDate', nullable: true)
  DateTime? get dietCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietId')
  int? get dietId => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietBreakfast')
  String? get dietBreakfast => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietRefreshment')
  String? get dietRefreshment => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietLunch')
  String? get dietLunch => throw _privateConstructorUsedError;
  @JsonKey(name: 'dietDinner')
  String? get dietDinner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentDietModelCopyWith<ScaleTreatmentDietModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentDietModelCopyWith<$Res> {
  factory $ScaleTreatmentDietModelCopyWith(ScaleTreatmentDietModel value,
          $Res Function(ScaleTreatmentDietModel) then) =
      _$ScaleTreatmentDietModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'dietId') int? dietId,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'dietBreakfast') String? dietBreakfast,
      @JsonKey(name: 'dietRefreshment') String? dietRefreshment,
      @JsonKey(name: 'dietLunch') String? dietLunch,
      @JsonKey(name: 'dietDinner') String? dietDinner});
}

/// @nodoc
class _$ScaleTreatmentDietModelCopyWithImpl<$Res>
    implements $ScaleTreatmentDietModelCopyWith<$Res> {
  _$ScaleTreatmentDietModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentDietModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentDietModel) _then;

  @override
  $Res call({
    Object? dietTitle = freezed,
    Object? dietCreateDate = freezed,
    Object? dietId = freezed,
    Object? createdByName = freezed,
    Object? dietBreakfast = freezed,
    Object? dietRefreshment = freezed,
    Object? dietLunch = freezed,
    Object? dietDinner = freezed,
  }) {
    return _then(_value.copyWith(
      dietTitle: dietTitle == freezed
          ? _value.dietTitle
          : dietTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dietCreateDate: dietCreateDate == freezed
          ? _value.dietCreateDate
          : dietCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dietId: dietId == freezed
          ? _value.dietId
          : dietId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      dietBreakfast: dietBreakfast == freezed
          ? _value.dietBreakfast
          : dietBreakfast // ignore: cast_nullable_to_non_nullable
              as String?,
      dietRefreshment: dietRefreshment == freezed
          ? _value.dietRefreshment
          : dietRefreshment // ignore: cast_nullable_to_non_nullable
              as String?,
      dietLunch: dietLunch == freezed
          ? _value.dietLunch
          : dietLunch // ignore: cast_nullable_to_non_nullable
              as String?,
      dietDinner: dietDinner == freezed
          ? _value.dietDinner
          : dietDinner // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ScaleTreatmentDietModelCopyWith<$Res>
    implements $ScaleTreatmentDietModelCopyWith<$Res> {
  factory _$ScaleTreatmentDietModelCopyWith(_ScaleTreatmentDietModel value,
          $Res Function(_ScaleTreatmentDietModel) then) =
      __$ScaleTreatmentDietModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'dietId') int? dietId,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'dietBreakfast') String? dietBreakfast,
      @JsonKey(name: 'dietRefreshment') String? dietRefreshment,
      @JsonKey(name: 'dietLunch') String? dietLunch,
      @JsonKey(name: 'dietDinner') String? dietDinner});
}

/// @nodoc
class __$ScaleTreatmentDietModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentDietModelCopyWithImpl<$Res>
    implements _$ScaleTreatmentDietModelCopyWith<$Res> {
  __$ScaleTreatmentDietModelCopyWithImpl(_ScaleTreatmentDietModel _value,
      $Res Function(_ScaleTreatmentDietModel) _then)
      : super(_value, (v) => _then(v as _ScaleTreatmentDietModel));

  @override
  _ScaleTreatmentDietModel get _value =>
      super._value as _ScaleTreatmentDietModel;

  @override
  $Res call({
    Object? dietTitle = freezed,
    Object? dietCreateDate = freezed,
    Object? dietId = freezed,
    Object? createdByName = freezed,
    Object? dietBreakfast = freezed,
    Object? dietRefreshment = freezed,
    Object? dietLunch = freezed,
    Object? dietDinner = freezed,
  }) {
    return _then(_ScaleTreatmentDietModel(
      dietTitle: dietTitle == freezed
          ? _value.dietTitle
          : dietTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dietCreateDate: dietCreateDate == freezed
          ? _value.dietCreateDate
          : dietCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dietId: dietId == freezed
          ? _value.dietId
          : dietId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      dietBreakfast: dietBreakfast == freezed
          ? _value.dietBreakfast
          : dietBreakfast // ignore: cast_nullable_to_non_nullable
              as String?,
      dietRefreshment: dietRefreshment == freezed
          ? _value.dietRefreshment
          : dietRefreshment // ignore: cast_nullable_to_non_nullable
              as String?,
      dietLunch: dietLunch == freezed
          ? _value.dietLunch
          : dietLunch // ignore: cast_nullable_to_non_nullable
              as String?,
      dietDinner: dietDinner == freezed
          ? _value.dietDinner
          : dietDinner // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentDietModel extends _ScaleTreatmentDietModel {
  const _$_ScaleTreatmentDietModel(
      {@JsonKey(name: 'dietTitle') this.dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) this.dietCreateDate,
      @JsonKey(name: 'dietId') this.dietId,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'dietBreakfast') this.dietBreakfast,
      @JsonKey(name: 'dietRefreshment') this.dietRefreshment,
      @JsonKey(name: 'dietLunch') this.dietLunch,
      @JsonKey(name: 'dietDinner') this.dietDinner})
      : super._();

  factory _$_ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentDietModelFromJson(json);

  @override
  @JsonKey(name: 'dietTitle')
  final String? dietTitle;
  @override
  @JsonKey(name: 'dietCreateDate', nullable: true)
  final DateTime? dietCreateDate;
  @override
  @JsonKey(name: 'dietId')
  final int? dietId;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'dietBreakfast')
  final String? dietBreakfast;
  @override
  @JsonKey(name: 'dietRefreshment')
  final String? dietRefreshment;
  @override
  @JsonKey(name: 'dietLunch')
  final String? dietLunch;
  @override
  @JsonKey(name: 'dietDinner')
  final String? dietDinner;

  @override
  String toString() {
    return 'ScaleTreatmentDietModel(dietTitle: $dietTitle, dietCreateDate: $dietCreateDate, dietId: $dietId, createdByName: $createdByName, dietBreakfast: $dietBreakfast, dietRefreshment: $dietRefreshment, dietLunch: $dietLunch, dietDinner: $dietDinner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleTreatmentDietModel &&
            const DeepCollectionEquality().equals(other.dietTitle, dietTitle) &&
            const DeepCollectionEquality()
                .equals(other.dietCreateDate, dietCreateDate) &&
            const DeepCollectionEquality().equals(other.dietId, dietId) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality()
                .equals(other.dietBreakfast, dietBreakfast) &&
            const DeepCollectionEquality()
                .equals(other.dietRefreshment, dietRefreshment) &&
            const DeepCollectionEquality().equals(other.dietLunch, dietLunch) &&
            const DeepCollectionEquality()
                .equals(other.dietDinner, dietDinner));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dietTitle),
      const DeepCollectionEquality().hash(dietCreateDate),
      const DeepCollectionEquality().hash(dietId),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(dietBreakfast),
      const DeepCollectionEquality().hash(dietRefreshment),
      const DeepCollectionEquality().hash(dietLunch),
      const DeepCollectionEquality().hash(dietDinner));

  @JsonKey(ignore: true)
  @override
  _$ScaleTreatmentDietModelCopyWith<_ScaleTreatmentDietModel> get copyWith =>
      __$ScaleTreatmentDietModelCopyWithImpl<_ScaleTreatmentDietModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentDietModelToJson(this);
  }
}

abstract class _ScaleTreatmentDietModel extends ScaleTreatmentDietModel {
  const factory _ScaleTreatmentDietModel(
      {@JsonKey(name: 'dietTitle')
          String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true)
          DateTime? dietCreateDate,
      @JsonKey(name: 'dietId')
          int? dietId,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'dietBreakfast')
          String? dietBreakfast,
      @JsonKey(name: 'dietRefreshment')
          String? dietRefreshment,
      @JsonKey(name: 'dietLunch')
          String? dietLunch,
      @JsonKey(name: 'dietDinner')
          String? dietDinner}) = _$_ScaleTreatmentDietModel;
  const _ScaleTreatmentDietModel._() : super._();

  factory _ScaleTreatmentDietModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentDietModel.fromJson;

  @override
  @JsonKey(name: 'dietTitle')
  String? get dietTitle;
  @override
  @JsonKey(name: 'dietCreateDate', nullable: true)
  DateTime? get dietCreateDate;
  @override
  @JsonKey(name: 'dietId')
  int? get dietId;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName;
  @override
  @JsonKey(name: 'dietBreakfast')
  String? get dietBreakfast;
  @override
  @JsonKey(name: 'dietRefreshment')
  String? get dietRefreshment;
  @override
  @JsonKey(name: 'dietLunch')
  String? get dietLunch;
  @override
  @JsonKey(name: 'dietDinner')
  String? get dietDinner;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentDietModelCopyWith<_ScaleTreatmentDietModel> get copyWith =>
      throw _privateConstructorUsedError;
}
