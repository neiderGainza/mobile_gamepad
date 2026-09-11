// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Button {

 ButtonData get buttonData; ButtonType get buttonType; PlayerButton get buttonCode;
/// Create a copy of Button
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonCopyWith<Button> get copyWith => _$ButtonCopyWithImpl<Button>(this as Button, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Button&&(identical(other.buttonData, buttonData) || other.buttonData == buttonData)&&(identical(other.buttonType, buttonType) || other.buttonType == buttonType)&&(identical(other.buttonCode, buttonCode) || other.buttonCode == buttonCode));
}


@override
int get hashCode => Object.hash(runtimeType,buttonData,buttonType,buttonCode);

@override
String toString() {
  return 'Button(buttonData: $buttonData, buttonType: $buttonType, buttonCode: $buttonCode)';
}


}

/// @nodoc
abstract mixin class $ButtonCopyWith<$Res>  {
  factory $ButtonCopyWith(Button value, $Res Function(Button) _then) = _$ButtonCopyWithImpl;
@useResult
$Res call({
 ButtonData buttonData, ButtonType buttonType, PlayerButton buttonCode
});




}
/// @nodoc
class _$ButtonCopyWithImpl<$Res>
    implements $ButtonCopyWith<$Res> {
  _$ButtonCopyWithImpl(this._self, this._then);

  final Button _self;
  final $Res Function(Button) _then;

/// Create a copy of Button
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buttonData = null,Object? buttonType = null,Object? buttonCode = null,}) {
  return _then(Button(
buttonData: null == buttonData ? _self.buttonData : buttonData // ignore: cast_nullable_to_non_nullable
as ButtonData,buttonType: null == buttonType ? _self.buttonType : buttonType // ignore: cast_nullable_to_non_nullable
as ButtonType,buttonCode: null == buttonCode ? _self.buttonCode : buttonCode // ignore: cast_nullable_to_non_nullable
as PlayerButton,
  ));
}

}


/// Adds pattern-matching-related methods to [Button].
extension ButtonPatterns on Button {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
