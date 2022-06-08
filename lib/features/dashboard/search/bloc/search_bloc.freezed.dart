// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchEventCopyWith<$Res> {
  factory $SearchEventCopyWith(
          SearchEvent value, $Res Function(SearchEvent) then) =
      _$SearchEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchEventCopyWithImpl<$Res> implements $SearchEventCopyWith<$Res> {
  _$SearchEventCopyWithImpl(this._value, this._then);

  final SearchEvent _value;
  // ignore: unused_field
  final $Res Function(SearchEvent) _then;
}

/// @nodoc
abstract class _$$SearchFetchedCopyWith<$Res> {
  factory _$$SearchFetchedCopyWith(
          _$SearchFetched value, $Res Function(_$SearchFetched) then) =
      __$$SearchFetchedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchFetchedCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements _$$SearchFetchedCopyWith<$Res> {
  __$$SearchFetchedCopyWithImpl(
      _$SearchFetched _value, $Res Function(_$SearchFetched) _then)
      : super(_value, (v) => _then(v as _$SearchFetched));

  @override
  _$SearchFetched get _value => super._value as _$SearchFetched;
}

/// @nodoc

class _$SearchFetched implements SearchFetched {
  const _$SearchFetched();

  @override
  String toString() {
    return 'SearchEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchFetched);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class SearchFetched implements SearchEvent {
  const factory SearchFetched() = _$SearchFetched;
}

/// @nodoc
abstract class _$$SearchTextFilteredCopyWith<$Res> {
  factory _$$SearchTextFilteredCopyWith(_$SearchTextFiltered value,
          $Res Function(_$SearchTextFiltered) then) =
      __$$SearchTextFilteredCopyWithImpl<$Res>;
  $Res call({String input});
}

/// @nodoc
class __$$SearchTextFilteredCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements _$$SearchTextFilteredCopyWith<$Res> {
  __$$SearchTextFilteredCopyWithImpl(
      _$SearchTextFiltered _value, $Res Function(_$SearchTextFiltered) _then)
      : super(_value, (v) => _then(v as _$SearchTextFiltered));

  @override
  _$SearchTextFiltered get _value => super._value as _$SearchTextFiltered;

  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$SearchTextFiltered(
      input == freezed
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchTextFiltered implements SearchTextFiltered {
  const _$SearchTextFiltered(this.input);

  @override
  final String input;

  @override
  String toString() {
    return 'SearchEvent.textFilter(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTextFiltered &&
            const DeepCollectionEquality().equals(other.input, input));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(input));

  @JsonKey(ignore: true)
  @override
  _$$SearchTextFilteredCopyWith<_$SearchTextFiltered> get copyWith =>
      __$$SearchTextFilteredCopyWithImpl<_$SearchTextFiltered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return textFilter(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return textFilter?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (textFilter != null) {
      return textFilter(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return textFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return textFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (textFilter != null) {
      return textFilter(this);
    }
    return orElse();
  }
}

abstract class SearchTextFiltered implements SearchEvent {
  const factory SearchTextFiltered(final String input) = _$SearchTextFiltered;

  String get input => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SearchTextFilteredCopyWith<_$SearchTextFiltered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchPlatformFilteredCopyWith<$Res> {
  factory _$$SearchPlatformFilteredCopyWith(_$SearchPlatformFiltered value,
          $Res Function(_$SearchPlatformFiltered) then) =
      __$$SearchPlatformFilteredCopyWithImpl<$Res>;
  $Res call({SearchSocialType type});
}

/// @nodoc
class __$$SearchPlatformFilteredCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements _$$SearchPlatformFilteredCopyWith<$Res> {
  __$$SearchPlatformFilteredCopyWithImpl(_$SearchPlatformFiltered _value,
      $Res Function(_$SearchPlatformFiltered) _then)
      : super(_value, (v) => _then(v as _$SearchPlatformFiltered));

  @override
  _$SearchPlatformFiltered get _value =>
      super._value as _$SearchPlatformFiltered;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_$SearchPlatformFiltered(
      type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchSocialType,
    ));
  }
}

/// @nodoc

class _$SearchPlatformFiltered implements SearchPlatformFiltered {
  const _$SearchPlatformFiltered(this.type);

  @override
  final SearchSocialType type;

  @override
  String toString() {
    return 'SearchEvent.platformFilter(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPlatformFiltered &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$SearchPlatformFilteredCopyWith<_$SearchPlatformFiltered> get copyWith =>
      __$$SearchPlatformFilteredCopyWithImpl<_$SearchPlatformFiltered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return platformFilter(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return platformFilter?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (platformFilter != null) {
      return platformFilter(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return platformFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return platformFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (platformFilter != null) {
      return platformFilter(this);
    }
    return orElse();
  }
}

abstract class SearchPlatformFiltered implements SearchEvent {
  const factory SearchPlatformFiltered(final SearchSocialType type) =
      _$SearchPlatformFiltered;

  SearchSocialType get type => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SearchPlatformFilteredCopyWith<_$SearchPlatformFiltered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchFilterRetrievedCopyWith<$Res> {
  factory _$$SearchFilterRetrievedCopyWith(_$SearchFilterRetrieved value,
          $Res Function(_$SearchFilterRetrieved) then) =
      __$$SearchFilterRetrievedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchFilterRetrievedCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res>
    implements _$$SearchFilterRetrievedCopyWith<$Res> {
  __$$SearchFilterRetrievedCopyWithImpl(_$SearchFilterRetrieved _value,
      $Res Function(_$SearchFilterRetrieved) _then)
      : super(_value, (v) => _then(v as _$SearchFilterRetrieved));

  @override
  _$SearchFilterRetrieved get _value => super._value as _$SearchFilterRetrieved;
}

/// @nodoc

class _$SearchFilterRetrieved implements SearchFilterRetrieved {
  const _$SearchFilterRetrieved();

  @override
  String toString() {
    return 'SearchEvent.filterRetrieved()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchFilterRetrieved);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(String input) textFilter,
    required TResult Function(SearchSocialType type) platformFilter,
    required TResult Function() filterRetrieved,
  }) {
    return filterRetrieved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
  }) {
    return filterRetrieved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(String input)? textFilter,
    TResult Function(SearchSocialType type)? platformFilter,
    TResult Function()? filterRetrieved,
    required TResult orElse(),
  }) {
    if (filterRetrieved != null) {
      return filterRetrieved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchFetched value) fetch,
    required TResult Function(SearchTextFiltered value) textFilter,
    required TResult Function(SearchPlatformFiltered value) platformFilter,
    required TResult Function(SearchFilterRetrieved value) filterRetrieved,
  }) {
    return filterRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
  }) {
    return filterRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchFetched value)? fetch,
    TResult Function(SearchTextFiltered value)? textFilter,
    TResult Function(SearchPlatformFiltered value)? platformFilter,
    TResult Function(SearchFilterRetrieved value)? filterRetrieved,
    required TResult orElse(),
  }) {
    if (filterRetrieved != null) {
      return filterRetrieved(this);
    }
    return orElse();
  }
}

abstract class SearchFilterRetrieved implements SearchEvent {
  const factory SearchFilterRetrieved() = _$SearchFilterRetrieved;
}

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  final SearchState _value;
  // ignore: unused_field
  final $Res Function(SearchState) _then;
}

/// @nodoc
abstract class _$$SearchInitialCopyWith<$Res> {
  factory _$$SearchInitialCopyWith(
          _$SearchInitial value, $Res Function(_$SearchInitial) then) =
      __$$SearchInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchInitialCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements _$$SearchInitialCopyWith<$Res> {
  __$$SearchInitialCopyWithImpl(
      _$SearchInitial _value, $Res Function(_$SearchInitial) _then)
      : super(_value, (v) => _then(v as _$SearchInitial));

  @override
  _$SearchInitial get _value => super._value as _$SearchInitial;
}

/// @nodoc

class _$SearchInitial implements SearchInitial {
  const _$SearchInitial();

  @override
  String toString() {
    return 'SearchState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchInitial implements SearchState {
  const factory SearchInitial() = _$SearchInitial;
}

/// @nodoc
abstract class _$$SearchLoadInProgressCopyWith<$Res> {
  factory _$$SearchLoadInProgressCopyWith(_$SearchLoadInProgress value,
          $Res Function(_$SearchLoadInProgress) then) =
      __$$SearchLoadInProgressCopyWithImpl<$Res>;
  $Res call({List<SearchSocialType>? socialTypes});
}

/// @nodoc
class __$$SearchLoadInProgressCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements _$$SearchLoadInProgressCopyWith<$Res> {
  __$$SearchLoadInProgressCopyWithImpl(_$SearchLoadInProgress _value,
      $Res Function(_$SearchLoadInProgress) _then)
      : super(_value, (v) => _then(v as _$SearchLoadInProgress));

  @override
  _$SearchLoadInProgress get _value => super._value as _$SearchLoadInProgress;

  @override
  $Res call({
    Object? socialTypes = freezed,
  }) {
    return _then(_$SearchLoadInProgress(
      socialTypes == freezed
          ? _value._socialTypes
          : socialTypes // ignore: cast_nullable_to_non_nullable
              as List<SearchSocialType>?,
    ));
  }
}

/// @nodoc

class _$SearchLoadInProgress implements SearchLoadInProgress {
  const _$SearchLoadInProgress(final List<SearchSocialType>? socialTypes)
      : _socialTypes = socialTypes;

  final List<SearchSocialType>? _socialTypes;
  @override
  List<SearchSocialType>? get socialTypes {
    final value = _socialTypes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SearchState.loadInProgress(socialTypes: $socialTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchLoadInProgress &&
            const DeepCollectionEquality()
                .equals(other._socialTypes, _socialTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_socialTypes));

  @JsonKey(ignore: true)
  @override
  _$$SearchLoadInProgressCopyWith<_$SearchLoadInProgress> get copyWith =>
      __$$SearchLoadInProgressCopyWithImpl<_$SearchLoadInProgress>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return loadInProgress(socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return loadInProgress?.call(socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(socialTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class SearchLoadInProgress implements SearchState {
  const factory SearchLoadInProgress(
      final List<SearchSocialType>? socialTypes) = _$SearchLoadInProgress;

  List<SearchSocialType>? get socialTypes => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SearchLoadInProgressCopyWith<_$SearchLoadInProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSuccessCopyWith<$Res> {
  factory _$$SearchSuccessCopyWith(
          _$SearchSuccess value, $Res Function(_$SearchSuccess) then) =
      __$$SearchSuccessCopyWithImpl<$Res>;
  $Res call({List<SearchModel> list, List<SearchSocialType> socialTypes});
}

/// @nodoc
class __$$SearchSuccessCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements _$$SearchSuccessCopyWith<$Res> {
  __$$SearchSuccessCopyWithImpl(
      _$SearchSuccess _value, $Res Function(_$SearchSuccess) _then)
      : super(_value, (v) => _then(v as _$SearchSuccess));

  @override
  _$SearchSuccess get _value => super._value as _$SearchSuccess;

  @override
  $Res call({
    Object? list = freezed,
    Object? socialTypes = freezed,
  }) {
    return _then(_$SearchSuccess(
      list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<SearchModel>,
      socialTypes == freezed
          ? _value._socialTypes
          : socialTypes // ignore: cast_nullable_to_non_nullable
              as List<SearchSocialType>,
    ));
  }
}

/// @nodoc

class _$SearchSuccess implements SearchSuccess {
  const _$SearchSuccess(
      final List<SearchModel> list, final List<SearchSocialType> socialTypes)
      : _list = list,
        _socialTypes = socialTypes;

  final List<SearchModel> _list;
  @override
  List<SearchModel> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<SearchSocialType> _socialTypes;
  @override
  List<SearchSocialType> get socialTypes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_socialTypes);
  }

  @override
  String toString() {
    return 'SearchState.success(list: $list, socialTypes: $socialTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSuccess &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality()
                .equals(other._socialTypes, _socialTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_socialTypes));

  @JsonKey(ignore: true)
  @override
  _$$SearchSuccessCopyWith<_$SearchSuccess> get copyWith =>
      __$$SearchSuccessCopyWithImpl<_$SearchSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return success(list, socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return success?.call(list, socialTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(list, socialTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SearchSuccess implements SearchState {
  const factory SearchSuccess(final List<SearchModel> list,
      final List<SearchSocialType> socialTypes) = _$SearchSuccess;

  List<SearchModel> get list => throw _privateConstructorUsedError;
  List<SearchSocialType> get socialTypes => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SearchSuccessCopyWith<_$SearchSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchFailureCopyWith<$Res> {
  factory _$$SearchFailureCopyWith(
          _$SearchFailure value, $Res Function(_$SearchFailure) then) =
      __$$SearchFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchFailureCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements _$$SearchFailureCopyWith<$Res> {
  __$$SearchFailureCopyWithImpl(
      _$SearchFailure _value, $Res Function(_$SearchFailure) _then)
      : super(_value, (v) => _then(v as _$SearchFailure));

  @override
  _$SearchFailure get _value => super._value as _$SearchFailure;
}

/// @nodoc

class _$SearchFailure implements SearchFailure {
  const _$SearchFailure();

  @override
  String toString() {
    return 'SearchState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SearchSocialType>? socialTypes)
        loadInProgress,
    required TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)
        success,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SearchSocialType>? socialTypes)? loadInProgress,
    TResult Function(
            List<SearchModel> list, List<SearchSocialType> socialTypes)?
        success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchInitial value) initial,
    required TResult Function(SearchLoadInProgress value) loadInProgress,
    required TResult Function(SearchSuccess value) success,
    required TResult Function(SearchFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchInitial value)? initial,
    TResult Function(SearchLoadInProgress value)? loadInProgress,
    TResult Function(SearchSuccess value)? success,
    TResult Function(SearchFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class SearchFailure implements SearchState {
  const factory SearchFailure() = _$SearchFailure;
}
