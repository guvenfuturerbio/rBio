// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scale_treatment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScaleTreatmentResponse _$ScaleTreatmentResponseFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentResponse.fromJson(json);
}

/// @nodoc
class _$ScaleTreatmentResponseTearOff {
  const _$ScaleTreatmentResponseTearOff();

  _ScaleTreatmentResponse call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          List<ScaleTreatmentDoctorNoteModel>? doctorNoteList}) {
    return _ScaleTreatmentResponse(
      treatmentNoteList: treatmentNoteList,
      dietList: dietList,
      doctorNoteList: doctorNoteList,
    );
  }

  ScaleTreatmentResponse fromJson(Map<String, Object?> json) {
    return ScaleTreatmentResponse.fromJson(json);
  }
}

/// @nodoc
const $ScaleTreatmentResponse = _$ScaleTreatmentResponseTearOff();

/// @nodoc
mixin _$ScaleTreatmentResponse {
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'doctorNoteList')
  List<ScaleTreatmentDoctorNoteModel>? get doctorNoteList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentResponseCopyWith<ScaleTreatmentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentResponseCopyWith<$Res> {
  factory $ScaleTreatmentResponseCopyWith(ScaleTreatmentResponse value,
          $Res Function(ScaleTreatmentResponse) then) =
      _$ScaleTreatmentResponseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          List<ScaleTreatmentDoctorNoteModel>? doctorNoteList});
}

/// @nodoc
class _$ScaleTreatmentResponseCopyWithImpl<$Res>
    implements $ScaleTreatmentResponseCopyWith<$Res> {
  _$ScaleTreatmentResponseCopyWithImpl(this._value, this._then);

  final ScaleTreatmentResponse _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentResponse) _then;

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
              as List<ScaleTreatmentDoctorNoteModel>?,
    ));
  }
}

/// @nodoc
abstract class _$ScaleTreatmentResponseCopyWith<$Res>
    implements $ScaleTreatmentResponseCopyWith<$Res> {
  factory _$ScaleTreatmentResponseCopyWith(_ScaleTreatmentResponse value,
          $Res Function(_ScaleTreatmentResponse) then) =
      __$ScaleTreatmentResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteList')
          List<ScaleTreatmentModel>? treatmentNoteList,
      @JsonKey(name: 'dietList')
          List<ScaleTreatmentDietModel>? dietList,
      @JsonKey(name: 'doctorNoteList')
          List<ScaleTreatmentDoctorNoteModel>? doctorNoteList});
}

/// @nodoc
class __$ScaleTreatmentResponseCopyWithImpl<$Res>
    extends _$ScaleTreatmentResponseCopyWithImpl<$Res>
    implements _$ScaleTreatmentResponseCopyWith<$Res> {
  __$ScaleTreatmentResponseCopyWithImpl(_ScaleTreatmentResponse _value,
      $Res Function(_ScaleTreatmentResponse) _then)
      : super(_value, (v) => _then(v as _ScaleTreatmentResponse));

  @override
  _ScaleTreatmentResponse get _value => super._value as _ScaleTreatmentResponse;

  @override
  $Res call({
    Object? treatmentNoteList = freezed,
    Object? dietList = freezed,
    Object? doctorNoteList = freezed,
  }) {
    return _then(_ScaleTreatmentResponse(
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
              as List<ScaleTreatmentDoctorNoteModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentResponse extends _ScaleTreatmentResponse {
  const _$_ScaleTreatmentResponse(
      {@JsonKey(name: 'treatmentNoteList') this.treatmentNoteList,
      @JsonKey(name: 'dietList') this.dietList,
      @JsonKey(name: 'doctorNoteList') this.doctorNoteList})
      : super._();

  factory _$_ScaleTreatmentResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ScaleTreatmentResponseFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteList')
  final List<ScaleTreatmentModel>? treatmentNoteList;
  @override
  @JsonKey(name: 'dietList')
  final List<ScaleTreatmentDietModel>? dietList;
  @override
  @JsonKey(name: 'doctorNoteList')
  final List<ScaleTreatmentDoctorNoteModel>? doctorNoteList;

  @override
  String toString() {
    return 'ScaleTreatmentResponse(treatmentNoteList: $treatmentNoteList, dietList: $dietList, doctorNoteList: $doctorNoteList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleTreatmentResponse &&
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
  _$ScaleTreatmentResponseCopyWith<_ScaleTreatmentResponse> get copyWith =>
      __$ScaleTreatmentResponseCopyWithImpl<_ScaleTreatmentResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentResponseToJson(this);
  }
}

abstract class _ScaleTreatmentResponse extends ScaleTreatmentResponse {
  const factory _ScaleTreatmentResponse(
          {@JsonKey(name: 'treatmentNoteList')
              List<ScaleTreatmentModel>? treatmentNoteList,
          @JsonKey(name: 'dietList')
              List<ScaleTreatmentDietModel>? dietList,
          @JsonKey(name: 'doctorNoteList')
              List<ScaleTreatmentDoctorNoteModel>? doctorNoteList}) =
      _$_ScaleTreatmentResponse;
  const _ScaleTreatmentResponse._() : super._();

  factory _ScaleTreatmentResponse.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentResponse.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteList')
  List<ScaleTreatmentModel>? get treatmentNoteList;
  @override
  @JsonKey(name: 'dietList')
  List<ScaleTreatmentDietModel>? get dietList;
  @override
  @JsonKey(name: 'doctorNoteList')
  List<ScaleTreatmentDoctorNoteModel>? get doctorNoteList;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentResponseCopyWith<_ScaleTreatmentResponse> get copyWith =>
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
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id}) {
    return _ScaleTreatmentModel(
      treatmentNoteTitle: treatmentNoteTitle,
      treatmentNoteCreateDate: treatmentNoteCreateDate,
      createdByName: createdByName,
      id: id,
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
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
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
    Object? createdByName = freezed,
    Object? id = freezed,
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
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
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
    Object? createdByName = freezed,
    Object? id = freezed,
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
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentModel extends _ScaleTreatmentModel {
  const _$_ScaleTreatmentModel(
      {@JsonKey(name: 'treatmentNoteTitle') this.treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate') this.treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
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
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentModel(treatmentNoteTitle: $treatmentNoteTitle, treatmentNoteCreateDate: $treatmentNoteCreateDate, createdByName: $createdByName, id: $id)';
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
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteTitle),
      const DeepCollectionEquality().hash(treatmentNoteCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

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
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id}) = _$_ScaleTreatmentModel;
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
  @JsonKey(name: 'createdByName')
  String? get createdByName;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentModelCopyWith<_ScaleTreatmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ScaleTreatmentDoctorNoteModel _$ScaleTreatmentDoctorNoteModelFromJson(
    Map<String, dynamic> json) {
  return _ScaleTreatmentDoctorNoteModel.fromJson(json);
}

/// @nodoc
class _$ScaleTreatmentDoctorNoteModelTearOff {
  const _$ScaleTreatmentDoctorNoteModelTearOff();

  _ScaleTreatmentDoctorNoteModel call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id}) {
    return _ScaleTreatmentDoctorNoteModel(
      treatmentNoteTitle: treatmentNoteTitle,
      treatmentNoteCreateDate: treatmentNoteCreateDate,
      createdByName: createdByName,
      id: id,
    );
  }

  ScaleTreatmentDoctorNoteModel fromJson(Map<String, Object?> json) {
    return ScaleTreatmentDoctorNoteModel.fromJson(json);
  }
}

/// @nodoc
const $ScaleTreatmentDoctorNoteModel = _$ScaleTreatmentDoctorNoteModelTearOff();

/// @nodoc
mixin _$ScaleTreatmentDoctorNoteModel {
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScaleTreatmentDoctorNoteModelCopyWith<ScaleTreatmentDoctorNoteModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  factory $ScaleTreatmentDoctorNoteModelCopyWith(
          ScaleTreatmentDoctorNoteModel value,
          $Res Function(ScaleTreatmentDoctorNoteModel) then) =
      _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    implements $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  _$ScaleTreatmentDoctorNoteModelCopyWithImpl(this._value, this._then);

  final ScaleTreatmentDoctorNoteModel _value;
  // ignore: unused_field
  final $Res Function(ScaleTreatmentDoctorNoteModel) _then;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
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
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$ScaleTreatmentDoctorNoteModelCopyWith<$Res>
    implements $ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  factory _$ScaleTreatmentDoctorNoteModelCopyWith(
          _ScaleTreatmentDoctorNoteModel value,
          $Res Function(_ScaleTreatmentDoctorNoteModel) then) =
      __$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id});
}

/// @nodoc
class __$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    extends _$ScaleTreatmentDoctorNoteModelCopyWithImpl<$Res>
    implements _$ScaleTreatmentDoctorNoteModelCopyWith<$Res> {
  __$ScaleTreatmentDoctorNoteModelCopyWithImpl(
      _ScaleTreatmentDoctorNoteModel _value,
      $Res Function(_ScaleTreatmentDoctorNoteModel) _then)
      : super(_value, (v) => _then(v as _ScaleTreatmentDoctorNoteModel));

  @override
  _ScaleTreatmentDoctorNoteModel get _value =>
      super._value as _ScaleTreatmentDoctorNoteModel;

  @override
  $Res call({
    Object? treatmentNoteTitle = freezed,
    Object? treatmentNoteCreateDate = freezed,
    Object? createdByName = freezed,
    Object? id = freezed,
  }) {
    return _then(_ScaleTreatmentDoctorNoteModel(
      treatmentNoteTitle: treatmentNoteTitle == freezed
          ? _value.treatmentNoteTitle
          : treatmentNoteTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      treatmentNoteCreateDate: treatmentNoteCreateDate == freezed
          ? _value.treatmentNoteCreateDate
          : treatmentNoteCreateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentDoctorNoteModel extends _ScaleTreatmentDoctorNoteModel {
  const _$_ScaleTreatmentDoctorNoteModel(
      {@JsonKey(name: 'treatmentNoteTitle') this.treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate') this.treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
      : super._();

  factory _$_ScaleTreatmentDoctorNoteModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_ScaleTreatmentDoctorNoteModelFromJson(json);

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  final String? treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  final DateTime? treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentDoctorNoteModel(treatmentNoteTitle: $treatmentNoteTitle, treatmentNoteCreateDate: $treatmentNoteCreateDate, createdByName: $createdByName, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleTreatmentDoctorNoteModel &&
            const DeepCollectionEquality()
                .equals(other.treatmentNoteTitle, treatmentNoteTitle) &&
            const DeepCollectionEquality().equals(
                other.treatmentNoteCreateDate, treatmentNoteCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(treatmentNoteTitle),
      const DeepCollectionEquality().hash(treatmentNoteCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$ScaleTreatmentDoctorNoteModelCopyWith<_ScaleTreatmentDoctorNoteModel>
      get copyWith => __$ScaleTreatmentDoctorNoteModelCopyWithImpl<
          _ScaleTreatmentDoctorNoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScaleTreatmentDoctorNoteModelToJson(this);
  }
}

abstract class _ScaleTreatmentDoctorNoteModel
    extends ScaleTreatmentDoctorNoteModel {
  const factory _ScaleTreatmentDoctorNoteModel(
      {@JsonKey(name: 'treatmentNoteTitle')
          String? treatmentNoteTitle,
      @JsonKey(name: 'treatmentNoteCreateDate')
          DateTime? treatmentNoteCreateDate,
      @JsonKey(name: 'createdByName')
          String? createdByName,
      @JsonKey(name: 'id')
          int? id}) = _$_ScaleTreatmentDoctorNoteModel;
  const _ScaleTreatmentDoctorNoteModel._() : super._();

  factory _ScaleTreatmentDoctorNoteModel.fromJson(Map<String, dynamic> json) =
      _$_ScaleTreatmentDoctorNoteModel.fromJson;

  @override
  @JsonKey(name: 'treatmentNoteTitle')
  String? get treatmentNoteTitle;
  @override
  @JsonKey(name: 'treatmentNoteCreateDate')
  DateTime? get treatmentNoteCreateDate;
  @override
  @JsonKey(name: 'createdByName')
  String? get createdByName;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentDoctorNoteModelCopyWith<_ScaleTreatmentDoctorNoteModel>
      get copyWith => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id}) {
    return _ScaleTreatmentDietModel(
      dietTitle: dietTitle,
      dietCreateDate: dietCreateDate,
      createdByName: createdByName,
      id: id,
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
  @JsonKey(name: 'createdByName')
  String? get createdByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id});
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
    Object? createdByName = freezed,
    Object? id = freezed,
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
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id});
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
    Object? createdByName = freezed,
    Object? id = freezed,
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
      createdByName: createdByName == freezed
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScaleTreatmentDietModel extends _ScaleTreatmentDietModel {
  const _$_ScaleTreatmentDietModel(
      {@JsonKey(name: 'dietTitle') this.dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) this.dietCreateDate,
      @JsonKey(name: 'createdByName') this.createdByName,
      @JsonKey(name: 'id') this.id})
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
  @JsonKey(name: 'createdByName')
  final String? createdByName;
  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  String toString() {
    return 'ScaleTreatmentDietModel(dietTitle: $dietTitle, dietCreateDate: $dietCreateDate, createdByName: $createdByName, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScaleTreatmentDietModel &&
            const DeepCollectionEquality().equals(other.dietTitle, dietTitle) &&
            const DeepCollectionEquality()
                .equals(other.dietCreateDate, dietCreateDate) &&
            const DeepCollectionEquality()
                .equals(other.createdByName, createdByName) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dietTitle),
      const DeepCollectionEquality().hash(dietCreateDate),
      const DeepCollectionEquality().hash(createdByName),
      const DeepCollectionEquality().hash(id));

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
      {@JsonKey(name: 'dietTitle') String? dietTitle,
      @JsonKey(name: 'dietCreateDate', nullable: true) DateTime? dietCreateDate,
      @JsonKey(name: 'createdByName') String? createdByName,
      @JsonKey(name: 'id') int? id}) = _$_ScaleTreatmentDietModel;
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
  @JsonKey(name: 'createdByName')
  String? get createdByName;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$ScaleTreatmentDietModelCopyWith<_ScaleTreatmentDietModel> get copyWith =>
      throw _privateConstructorUsedError;
}
