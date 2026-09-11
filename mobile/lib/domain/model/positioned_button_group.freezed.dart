// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'positioned_button_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PositionedButtonGroup {

 ButtonGroup get buttonGroup; Offset get relativePosition;
/// Create a copy of PositionedButtonGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionedButtonGroupCopyWith<PositionedButtonGroup> get copyWith => _$PositionedButtonGroupCopyWithImpl<PositionedButtonGroup>(this as PositionedButtonGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PositionedButtonGroup&&(identical(other.buttonGroup, buttonGroup) || other.buttonGroup == buttonGroup)&&(identical(other.relativePosition, relativePosition) || other.relativePosition == relativePosition));
}


@override
int get hashCode => Object.hash(runtimeType,buttonGroup,relativePosition);

@override
String toString() {
  return 'PositionedButtonGroup(buttonGroup: $buttonGroup, relativePosition: $relativePosition)';
}


}

/// @nodoc
abstract mixin class $PositionedButtonGroupCopyWith<$Res>  {
  factory $PositionedButtonGroupCopyWith(PositionedButtonGroup value, $Res Function(PositionedButtonGroup) _then) = _$PositionedButtonGroupCopyWithImpl;
@useResult
$Res call({
 ButtonGroup buttonGroup, Offset relativePosition
});




}
/// @nodoc
class _$PositionedButtonGroupCopyWithImpl<$Res>
    implements $PositionedButtonGroupCopyWith<$Res> {
  _$PositionedButtonGroupCopyWithImpl(this._self, this._then);

  final PositionedButtonGroup _self;
  final $Res Function(PositionedButtonGroup) _then;

/// Create a copy of PositionedButtonGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buttonGroup = null,Object? relativePosition = null,}) {
  return _then(PositionedButtonGroup(
buttonGroup: null == buttonGroup ? _self.buttonGroup : buttonGroup // ignore: cast_nullable_to_non_nullable
as ButtonGroup,relativePosition: null == relativePosition ? _self.relativePosition : relativePosition // ignore: cast_nullable_to_non_nullable
as Offset,
  ));
}

}


/// Adds pattern-matching-related methods to [PositionedButtonGroup].
extension PositionedButtonGroupPatterns on PositionedButtonGroup {
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
