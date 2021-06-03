// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'number_trivia.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NumberTrivia _$NumberTriviaFromJson(Map<String, dynamic> json) {
  return _NumberTrivia.fromJson(json);
}

/// @nodoc
class _$NumberTriviaTearOff {
  const _$NumberTriviaTearOff();

  _NumberTrivia call({required String text, required int number}) {
    return _NumberTrivia(
      text: text,
      number: number,
    );
  }

  NumberTrivia fromJson(Map<String, Object> json) {
    return NumberTrivia.fromJson(json);
  }
}

/// @nodoc
const $NumberTrivia = _$NumberTriviaTearOff();

/// @nodoc
mixin _$NumberTrivia {
  String get text => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NumberTriviaCopyWith<NumberTrivia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumberTriviaCopyWith<$Res> {
  factory $NumberTriviaCopyWith(
          NumberTrivia value, $Res Function(NumberTrivia) then) =
      _$NumberTriviaCopyWithImpl<$Res>;
  $Res call({String text, int number});
}

/// @nodoc
class _$NumberTriviaCopyWithImpl<$Res> implements $NumberTriviaCopyWith<$Res> {
  _$NumberTriviaCopyWithImpl(this._value, this._then);

  final NumberTrivia _value;
  // ignore: unused_field
  final $Res Function(NumberTrivia) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NumberTriviaCopyWith<$Res>
    implements $NumberTriviaCopyWith<$Res> {
  factory _$NumberTriviaCopyWith(
          _NumberTrivia value, $Res Function(_NumberTrivia) then) =
      __$NumberTriviaCopyWithImpl<$Res>;
  @override
  $Res call({String text, int number});
}

/// @nodoc
class __$NumberTriviaCopyWithImpl<$Res> extends _$NumberTriviaCopyWithImpl<$Res>
    implements _$NumberTriviaCopyWith<$Res> {
  __$NumberTriviaCopyWithImpl(
      _NumberTrivia _value, $Res Function(_NumberTrivia) _then)
      : super(_value, (v) => _then(v as _NumberTrivia));

  @override
  _NumberTrivia get _value => super._value as _NumberTrivia;

  @override
  $Res call({
    Object? text = freezed,
    Object? number = freezed,
  }) {
    return _then(_NumberTrivia(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NumberTrivia implements _NumberTrivia {
  _$_NumberTrivia({required this.text, required this.number});

  factory _$_NumberTrivia.fromJson(Map<String, dynamic> json) =>
      _$_$_NumberTriviaFromJson(json);

  @override
  final String text;
  @override
  final int number;

  @override
  String toString() {
    return 'NumberTrivia(text: $text, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NumberTrivia &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith =>
      __$NumberTriviaCopyWithImpl<_NumberTrivia>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NumberTriviaToJson(this);
  }
}

abstract class _NumberTrivia implements NumberTrivia {
  factory _NumberTrivia({required String text, required int number}) =
      _$_NumberTrivia;

  factory _NumberTrivia.fromJson(Map<String, dynamic> json) =
      _$_NumberTrivia.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  int get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith =>
      throw _privateConstructorUsedError;
}
