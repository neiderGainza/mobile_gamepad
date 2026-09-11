// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ButtonData {

 BoxShape get shape; int? get backgroundColorValue; int? get borderColorValue; int? get colorValue; int get elevation; double? get borderWidth; String get label; int? get borderRadius;
/// Create a copy of ButtonData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonDataCopyWith<ButtonData> get copyWith => _$ButtonDataCopyWithImpl<ButtonData>(this as ButtonData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonData&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.backgroundColorValue, backgroundColorValue) || other.backgroundColorValue == backgroundColorValue)&&(identical(other.borderColorValue, borderColorValue) || other.borderColorValue == borderColorValue)&&(identical(other.colorValue, colorValue) || other.colorValue == colorValue)&&(identical(other.elevation, elevation) || other.elevation == elevation)&&(identical(other.borderWidth, borderWidth) || other.borderWidth == borderWidth)&&(identical(other.label, label) || other.label == label)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius));
}


@override
int get hashCode => Object.hash(runtimeType,shape,backgroundColorValue,borderColorValue,colorValue,elevation,borderWidth,label,borderRadius);

@override
String toString() {
  return 'ButtonData(shape: $shape, backgroundColorValue: $backgroundColorValue, borderColorValue: $borderColorValue, colorValue: $colorValue, elevation: $elevation, borderWidth: $borderWidth, label: $label, borderRadius: $borderRadius)';
}


}

/// @nodoc
abstract mixin class $ButtonDataCopyWith<$Res>  {
  factory $ButtonDataCopyWith(ButtonData value, $Res Function(ButtonData) _then) = _$ButtonDataCopyWithImpl;
@useResult
$Res call({
 String label, BoxShape shape, int? backgroundColorValue, int? borderColorValue, int? colorValue, double? borderWidth, int? borderRadius, int elevation
});




}
/// @nodoc
class _$ButtonDataCopyWithImpl<$Res>
    implements $ButtonDataCopyWith<$Res> {
  _$ButtonDataCopyWithImpl(this._self, this._then);

  final ButtonData _self;
  final $Res Function(ButtonData) _then;

/// Create a copy of ButtonData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? shape = null,Object? backgroundColorValue = freezed,Object? borderColorValue = freezed,Object? colorValue = freezed,Object? borderWidth = freezed,Object? borderRadius = freezed,Object? elevation = null,}) {
  return _then(ButtonData(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as BoxShape,backgroundColorValue: freezed == backgroundColorValue ? _self.backgroundColorValue : backgroundColorValue // ignore: cast_nullable_to_non_nullable
as int?,borderColorValue: freezed == borderColorValue ? _self.borderColorValue : borderColorValue // ignore: cast_nullable_to_non_nullable
as int?,colorValue: freezed == colorValue ? _self.colorValue : colorValue // ignore: cast_nullable_to_non_nullable
as int?,borderWidth: freezed == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double?,borderRadius: freezed == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as int?,elevation: null == elevation ? _self.elevation : elevation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonData].
extension ButtonDataPatterns on ButtonData {
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
