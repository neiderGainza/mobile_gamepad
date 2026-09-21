// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ButtonGroup {

 UnmodifiableListView<Button> get buttons; double get screenRelativeSize; double get internalMargin; int? get rotationDegreess;
/// Create a copy of ButtonGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonGroupCopyWith<ButtonGroup> get copyWith => _$ButtonGroupCopyWithImpl<ButtonGroup>(this as ButtonGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonGroup&&const DeepCollectionEquality().equals(other.buttons, buttons)&&(identical(other.screenRelativeSize, screenRelativeSize) || other.screenRelativeSize == screenRelativeSize)&&(identical(other.internalMargin, internalMargin) || other.internalMargin == internalMargin)&&(identical(other.rotationDegreess, rotationDegreess) || other.rotationDegreess == rotationDegreess));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(buttons),screenRelativeSize,internalMargin,rotationDegreess);

@override
String toString() {
  return 'ButtonGroup(buttons: $buttons, screenRelativeSize: $screenRelativeSize, internalMargin: $internalMargin, rotationDegreess: $rotationDegreess)';
}


}

/// @nodoc
abstract mixin class $ButtonGroupCopyWith<$Res>  {
  factory $ButtonGroupCopyWith(ButtonGroup value, $Res Function(ButtonGroup) _then) = _$ButtonGroupCopyWithImpl;
@useResult
$Res call({
 List<Button> buttons, double screenRelativeSize, double internalMargin, int? rotationDegreess
});




}
/// @nodoc
class _$ButtonGroupCopyWithImpl<$Res>
    implements $ButtonGroupCopyWith<$Res> {
  _$ButtonGroupCopyWithImpl(this._self, this._then);

  final ButtonGroup _self;
  final $Res Function(ButtonGroup) _then;

/// Create a copy of ButtonGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buttons = null,Object? screenRelativeSize = null,Object? internalMargin = null,Object? rotationDegreess = freezed,}) {
  return _then(ButtonGroup(
buttons: null == buttons ? _self.buttons! : buttons // ignore: cast_nullable_to_non_nullable
as List<Button>,screenRelativeSize: null == screenRelativeSize ? _self.screenRelativeSize : screenRelativeSize // ignore: cast_nullable_to_non_nullable
as double,internalMargin: null == internalMargin ? _self.internalMargin : internalMargin // ignore: cast_nullable_to_non_nullable
as double,rotationDegreess: freezed == rotationDegreess ? _self.rotationDegreess : rotationDegreess // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonGroup].
extension ButtonGroupPatterns on ButtonGroup {
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
